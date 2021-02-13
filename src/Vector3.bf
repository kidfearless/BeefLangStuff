using System;

namespace BeefLangStuff
{
	struct Vector3
	{
		internal int X;
		private int Y;
		protected int Z;
		public float Length
		{
			get
			{
				return Math.Sqrt((X * X) + (Y * Y) + (Z + Z));
			}
		}
	}
}
