using System;
using System.Collections;
using System.IO;

namespace BeefLangStuff
{
	struct Foo
	{
		public int Bar;
	}

	class Program3
	{
		public static void Main()
		{
			List<Foo> Bars = scope List<Foo>();
			SomeFunc(Bars);
			Foo foo = Bars[4];
			Console.WriteLine(foo.Bar);
		}

		static void SomeFunc(List<Foo> list)
		{
			var memory = scope MemoryStream();

			for(int i < 10)
			{
				Foo temp;
				temp.Bar = i;
				memory.Write(temp);
			}
			memory.Position = 0;
			for(int i < 10)
			{
				Foo temp = memory.Read<Foo>();
				list.Add(temp);
			}
		}
	}
}
