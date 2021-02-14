using System;
using System.Runtime.CompilerServices;
using System.Text;

namespace System.IO
{
	public static class FileStreamExtensions
	{
		public static void ReadToCharacter(this FileStream self, StringBuilder buffer, char end)
		{
			if(self.Position == self.Length)
			{
				return;
			}

			char @char;

			do
			{
				@char = (char)self.ReadByte();
				if (@char == end)
				{
					break;
				}

				buffer.Append(@char);
			} while (self.Position != self.Length);

		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void ReadString(this FileStream self, StringBuilder  buffer)
		{
			self.ReadToCharacter(buffer, '\0');
		}


		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void ReadLine(this FileStream self, StringBuilder buffer)
		{
			self.ReadToCharacter(buffer, '\n');
		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void ReadString(this FileStream self, out string output)
		{
			StringBuilder buffer = new();
			self.ReadToCharacter(buffer, '\0');
			output = buffer.ToString();
		}


		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void ReadLine(this FileStream self, out string output)
		{
			StringBuilder buffer = new();
			self.ReadToCharacter(buffer, '\n');
			output = buffer.ToString();
		}
	}
}