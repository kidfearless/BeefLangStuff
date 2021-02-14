using System;

namespace BeefLangStuff
{
	struct Vector2
	{
		public float X;
		public float Y;

		public float Length
		{
			get 
			{
				return Math.Sqrt((X * X) + (Y * Y));
			}
		}

		public void ToJSONObject(String buffer)
		{
			buffer.Append("{");
			buffer.Append(scope $"\"X\": {X},");
			buffer.Append(scope $"\t\"Y\": {Y}");
			buffer.Append("}");
		}
	}
}
