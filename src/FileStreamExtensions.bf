namespace System.IO
{
	extension FileStream
	{
		public Result<void> ReadToCharacter(String buffer, char8 end)
		{
			if(this.Position == this.Length)
			{
				return .Err;
			}

			char8 char;

			repeat
			{
				char = this.Read<char8>();
				if (char == end)
				{
					break;
				}
				
				buffer.Append(char);
			} while (this.Position != this.Length)


			return .Ok;
		}

		[Inline]
		public Result<void> ReadString(String buffer)
		{
			return ReadToCharacter(buffer, '\0');
		}


		[Inline]
		public Result<void> ReadLine(String buffer)
		{
			return ReadToCharacter(buffer, '\n');
		}
	}
}