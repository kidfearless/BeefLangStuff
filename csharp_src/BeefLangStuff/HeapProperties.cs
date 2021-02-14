using System;
using System.Collections;
using System.Collections.Generic;

namespace BeefLangStuff
{
	// shows classes having properties being created on the stack as well as on the heap
	class HeapProperties
	{
		protected List<int> someNumbers = null;
		protected bool IsSomeNumbersHeap = false;

		public List<int> SomeNumbers
		{
			get
			{
				return someNumbers;
			}
			protected set
			{
				someNumbers = value;
			}
		}

		public void SetSomeNumbers(ref List<int> numbers, bool isHeap = false)
		{
			SomeNumbers = numbers;
			IsSomeNumbersHeap = true;
		}

		public HeapProperties()
		{
		}

		~HeapProperties()
		{
			if (IsSomeNumbersHeap)
			{
				SomeNumbers = null;
			}
		}
	}
}
