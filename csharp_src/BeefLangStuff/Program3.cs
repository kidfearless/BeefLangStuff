using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;

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
			List<Foo> Bars = new List<Foo>();
			SomeFunc(Bars);
			Foo foo = Bars[4];
			Console.WriteLine(foo.Bar);

		}

		static void SomeFunc(List<Foo> list)
		{
			var memory = new MemoryStream();

			foreach(int i in Enumerable.Range(0, 10))
			{
				Foo temp;
				temp.Bar = i;
				
				//memory.Write(temp);
			}
			memory.Position = 0;
			foreach (int i in Enumerable.Range(0, 10))
			{
				//Foo temp = memory.Read<Foo>();
				//list.Add(temp);
			}

			memory.Dispose();
		}
	}
}
