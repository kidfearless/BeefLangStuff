using System;
using System.Text;

namespace BeefLangStuff
{
	struct Vector3
	{
		public float X;
		public float Y;
		public float Z;

		public float Length
		{
			get
			{
				return MathF.Sqrt((X * X) + (Y * Y) + (Z + Z));
			}
		}

		public void ToJSONObject(StringBuilder buffer)
		{
			buffer.Append("{");
			buffer.Append($"\"X\": {X}");
			buffer.Append($"\"Y\": {Y}");
			buffer.Append($"\"Z\": {Z}");
			buffer.Append("}");
		}
	}
}
