using System;

namespace BeefLangStuff
{
	class Program
	{

		public static int Main(String[] args)
		{
			MainScope:
			{
				CreateMemoryLeak();
				var input = ReadInput();
				WriteInput(input);

				delete input;
				return 0;
			}	
		}

		// this does indeed create a memory leak
		static void CreateMemoryLeak()
		{
			var x = new Vector3();
			Console.WriteLine(x.Length);
			x = null;
		}

		/*static String ReadInput()
		{
			var str = scope String();
			var _ = Console.ReadLine(str);
			// this will fail as the str is scoped to ReadInput
			return str;
		}*/

		/*static String ReadInput()
		{
			var str = scope:: String();
			var _ = Console.ReadLine(str);
			// this will also  fail as the str is still scoped to ReadInput
			return str;
		}*/

		/*static String ReadInput()
		{
			// this will fail as well, since we can't find the main scope
			var str = scope:MainScope String();
			var _ = Console.ReadLine(str);
		
			return str;
		}*/

		static String ReadInput()
		{
			// this should work as we are creating a heap string, this leaves the memory management to the caller
			var str = new String();
			var _ = Console.ReadLine(str);

			return str;
		}

		static void WriteInput(String str)
		{
			Console.WriteLine(str);
		}
	}
}