using System;

namespace BeefLangStuff
{
	struct Vector2
	{
		public int32 X;
		public int32 Y;

		public float Length
		{
			get
			{
				return Math.Sqrt((X * X) + (Y * Y));
			}
		}
	}
}
