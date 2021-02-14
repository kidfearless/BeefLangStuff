using System;
using System.Text;

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
				return MathF.Sqrt((X * X) + (Y * Y));
			}
		}

		public void ToJSONObject(StringBuilder buffer)
		{
			buffer.Append("{");
			buffer.Append($"\"X\": {X},");
			buffer.Append($"\t\"Y\": {Y}");
			buffer.Append("}");
		}
	}
}
