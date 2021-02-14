using System.Runtime.CompilerServices;
using System.Text;

namespace System.IO
{
	public static class BinaryReaderExtensions
	{
		public static void ReadToCharacter(this BinaryReader self, StringBuilder buffer, char end)
		{
			char @char;

			do
			{
				@char = self.ReadChar();
				if (@char == end)
				{
					break;
				}

				buffer.Append(@char);
			} while (true);

		}

		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void ReadString(this BinaryReader self, out string output)
		{
			StringBuilder buffer = new();
			self.ReadToCharacter(buffer, '\0');
			output = buffer.ToString();
		}


		[MethodImpl(MethodImplOptions.AggressiveInlining)]
		public static void ReadLine(this BinaryReader self, out string output)
		{
			StringBuilder buffer = new();
			self.ReadToCharacter(buffer, '\n');
			output = buffer.ToString();
		}
	}
}