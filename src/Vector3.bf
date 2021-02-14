using System;

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
				return Math.Sqrt((X * X) + (Y * Y) + (Z + Z));
			}
		}

		public void ToJSONObject(String buffer)
		{
			buffer.Append("{");
			buffer.Append(scope $"\"X\": {X}");
			buffer.Append(scope $"\"Y\": {Y}");
			buffer.Append(scope $"\"Z\": {Z}");
			buffer.Append("}");
		}
	}
}
