using System;
using System.IO;
using System.Collections;
using System.Diagnostics;
using System.Collections.Generic;
using System.Text;
using Microsoft.Win32;
using System.Runtime.InteropServices;

namespace BeefLangStuff
{
	class Program2
	{
		const string REPLAY_FORMAT_V2 = "{SHAVITREPLAYFORMAT}{V2}";
		const string REPLAY_FORMAT_FINAL = "{SHAVITREPLAYFORMAT}{FINAL}";
		const int REPLAY_FORMAT_SUBVERSION = 0x04;
		static void Main()
		{
			ShavitReplay replay = new();
			replay.Frames = new List<ReplayFrame>();

			
			GetFileLocations(out string inputFile, out string outputFile);


			Stopwatch watch = new Stopwatch();
			watch.Start();
			using FileStream stream = File.Open(inputFile.ToString(),
									FileMode.Open,
									FileAccess.ReadWrite,
									FileShare.ReadWrite);

			BinaryReader reader = new(stream, Encoding.UTF8);


			reader.ReadLine(out string header);

			var enumerator = header.Split(':');
			var version = enumerator[0];
			var format = enumerator[1];

			replay.Version = int.Parse(version);
			replay.Format = format;


			if (replay.Format == REPLAY_FORMAT_FINAL)
			{
				LoadCurrentReplayFormat(reader, ref replay);
			}
			else
			{
				// yeah we don't care about the old replay formats in this case
				return;
			}

			watch.Stop();

			Console.Write("File Read Time: ");
			Console.WriteLine(watch.Elapsed.TotalSeconds);

			watch.Restart();

			WriteToJSON(ref replay, outputFile);

			watch.Stop();

			Console.Write("File Write Time: ");
			Console.WriteLine(watch.Elapsed.TotalSeconds);
			Console.Read();
		}

		static void GetFileLocations(out string inputFile, out string outputFile)
		{
			inputFile = Console.ReadLine();
			outputFile = inputFile + ".json";
		}

		static void LoadCurrentReplayFormat(BinaryReader reader, ref ShavitReplay replay)
		{
			if (replay.Version >= 0x03)
			{
				reader.ReadString(out string map);
				replay.Map = map;
				replay.Style = reader.ReadByte();
				replay.Track = reader.ReadByte();
			}

			replay.PreFrames = reader.ReadInt32();
			replay.PreFrames = Math.Max(0, replay.PreFrames);
			replay.FrameCount = reader.ReadInt32();
			replay.Frames.Capacity = replay.FrameCount;
			replay.Time = reader.ReadSingle();

			if (replay.Version >= 0x04)
			{
				replay.SteamID = reader.ReadInt32();
			}
			else
			{
				reader.ReadString(out string auth);
				auth = auth.Replace("[U:1:", "");
				auth = auth.Substring(0, auth.Length - 1);
				replay.SteamID = Int32.Parse(auth);
			}

			int size = Marshal.SizeOf<ReplayFrame>();
			int sizeold = Marshal.SizeOf<ReplayFrameOld>();
			for (int i = 0; i < replay.FrameCount; i++)
			{
				if (replay.Version >= 0x02)
				{
					var bytes = new byte[size];

					reader.Read(bytes);

					var frame = GetStructure<ReplayFrame>(bytes);
					replay.Frames.Add(frame);
				}
				else
				{
					var bytes = new byte[sizeold];

					reader.Read(bytes);

					var frame = (ReplayFrame)GetStructure<ReplayFrameOld>(bytes);
					replay.Frames.Add(frame);
				}
			}
		}

		private static T GetStructure<T>(byte[] bytes)
		{
			var handle = GCHandle.Alloc(bytes, GCHandleType.Pinned);
			var structure = Marshal.PtrToStructure<T>(handle.AddrOfPinnedObject());
			handle.Free();
			return structure;
		}

		static void WriteToJSON(ref ShavitReplay replay, string path)
		{
			if (File.Exists(path))
			{
				File.Delete(path);
			}
			using FileStream stream = File.Open(path, FileMode.Create, FileAccess.Write, FileShare.None);
			using var writer = new StreamWriter(stream, Encoding.UTF8);
			writer.Write("{");
			writer.Write($"\"Version\": {replay.Version},");

			writer.Write($"\"Style\": {replay.Style},");
			writer.Write( $"\"Track\": {replay.Track},");
			writer.Write( $"\"PreFrames\": {replay.PreFrames},");
			writer.Write( $"\"FrameCount\": {replay.FrameCount},");
			writer.Write( $"\"SteamID\": {replay.SteamID},");
			writer.Write( $"\"Time\": {replay.Time},");
			writer.Write( $"\"Map\": \"{replay.Map}\",");
			writer.Write( $"\"Format\": \"{replay.Format}\",");
			writer.Write( $"\"Frames\": [");

			int i = 0;
			var buffer = new StringBuilder();
			foreach (ReplayFrame frame in replay.Frames)
			{
				frame.ToJSONObject(buffer);
				if (i++ != replay.FrameCount - 1)
				{
					buffer.Append(",");
				}
				writer.Write(buffer.ToString());
				buffer.Clear();
			}


			writer.Write("]}");
		}
	}
}
