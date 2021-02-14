using System;

namespace BeefLangStuff
{
	struct Vector3
	{
		public int32 X;
		public int32 Y;
		public int32 Z;

		public float Length
		{
			get
			{
				return Math.Sqrt((X * X) + (Y * Y) + (Z + Z));
			}
		}
	}
}
