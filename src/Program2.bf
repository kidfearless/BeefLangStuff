using System;
using System.IO;
using System.Collections;
using System.Diagnostics;

namespace BeefLangStuff
{
	class Program2
	{
		const String REPLAY_FORMAT_V2 = "{SHAVITREPLAYFORMAT}{V2}";
		const String REPLAY_FORMAT_FINAL = "{SHAVITREPLAYFORMAT}{FINAL}";
		const int REPLAY_FORMAT_SUBVERSION = 0x04;
		public static void Main(String[] args)
		{
			ShavitReplay replay = scope ShavitReplay();
			replay.SetMap(scope:: String(160));
			replay.SetFrames(scope:: List<ReplayFrame>());

			String inputFile = scope:: String();
			String outputFile = scope:: String();
			GetFileLocations(ref inputFile, ref outputFile);


			Stopwatch watch = scope Stopwatch(true);
			FileStream stream = scope:: FileStream();
			var err = stream.Open(inputFile, FileAccess.ReadWrite, FileShare.ReadWrite);
			if (err case .Err)
			{
				return;
			}
			var header = scope:: String(32);

			stream.ReadLine(header);

			var enumerator = header.Split(':');
			var version = enumerator.GetNext();
			var format = enumerator.GetNext();

			replay.Version = int.Parse(version).Value;
			replay.SetFormat(scope:: String(format));


			if (replay.Format == REPLAY_FORMAT_FINAL)
			{
				LoadCurrentReplayFormat(ref stream, ref replay);
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

			WriteToJSON(ref replay, ref outputFile);

			watch.Stop();

			Console.Write("File Write Time: ");
			Console.WriteLine(watch.Elapsed.TotalSeconds);
			Console.Read();
		}

		static void GetFileLocations(ref String inputFile, ref String outputFile)
		{
			OpenFileDialog dialog = scope OpenFileDialog();
			/*dialog.Multiselect = true;*/

			dialog.Title = "Select Input File";
			Result<DialogResult> result = dialog.ShowDialog();

			while (result.Value != DialogResult.OK)
			{
				dialog.ShowDialog();
			}

			inputFile.Set(dialog.FileNames[0]);
			outputFile.Append(inputFile);
			outputFile.Append(".json");

			result.Dispose();
		}

		static void LoadCurrentReplayFormat(ref FileStream stream, ref ShavitReplay replay)
		{
			if (replay.Version >= 0x03)
			{
				stream.ReadString(replay.Map);
				replay.Style = stream.Read<uint8>();
				replay.Track = stream.Read<uint8>();
			}

			replay.PreFrames = stream.Read<int32>();
			replay.PreFrames = Math.Max(0, replay.PreFrames);
			replay.FrameCount = stream.Read<int32>();
			replay.Frames.Capacity = replay.FrameCount;
			replay.Time = stream.Read<float>();

			if (replay.Version >= 0x04)
			{
				replay.SteamID = stream.Read<int32>();
			}
			else
			{
				var auth = scope String(32);
				stream.ReadString(auth);
				auth.Replace("[U:1:", "");
				auth.RemoveFromEnd(1);
				replay.SteamID = int32.Parse(auth);
			}

			for (int i = 0; i < replay.FrameCount; i++)
			{
				if (replay.Version >= 0x02)
				{
					var frame = stream.Read<ReplayFrame>().Value;
					replay.Frames.Add(frame);
				}
				else
				{
					var frame = (ReplayFrame)stream.Read<ReplayFrameOld>().Value;
					replay.Frames.Add(frame);
				}
			}
		}

		static void WriteToJSON(ref ShavitReplay replay, ref String path)
		{
			FileStream stream = scope FileStream();
			if (File.Exists(path))
			{
				File.Delete(path);
			}

			stream.Open(path, FileMode.Create, .Write, .None);
			stream.Write("{");
			stream.Write(scope $"\"Version\": {replay.Version},");

			stream.Write(scope $"\"Style\": {replay.Style},");
			stream.Write(scope $"\"Track\": {replay.Track},");
			stream.Write(scope $"\"PreFrames\": {replay.PreFrames},");
			stream.Write(scope $"\"FrameCount\": {replay.FrameCount},");
			stream.Write(scope $"\"SteamID\": {replay.SteamID},");
			stream.Write(scope $"\"Time\": {replay.Time},");
			stream.Write(scope $"\"Map\": \"{replay.Map}\",");
			stream.Write(scope $"\"Format\": \"{replay.Format}\",");
			stream.Write(scope $"\"Frames\": [");

			int i = 0;
			var buffer = scope:: String();
			for (ReplayFrame frame in replay.Frames)
			{
				frame.ToJSONObject(buffer);
				if (i++ != replay.FrameCount - 1)
				{
					buffer.Append(",");
				}
				stream.Write(buffer);
				buffer.Clear();
			}


			stream.Write("]}");
		}
	}
}
