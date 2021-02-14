using System;
using System.Text;

namespace BeefLangStuff
{
	struct ReplayFrame
	{
		public Vector3 Position;
		public Vector2 EyeAngles;
		public Int32 Buttons;
		public Int32 EntityFlags;
		public Int32 MoveType;

		public void ToJSONObject(StringBuilder buffer)
		{
			buffer.Append("{");
			var temp = new StringBuilder();
			this.Position.ToJSONObject(temp);
			buffer.Append($"\"Position\": {temp},");

			this.EyeAngles.ToJSONObject(temp);
			buffer.Append($"\"EyeAngles\": {temp},");

			buffer.Append($"\"Buttons\": {Buttons},");
			buffer.Append($"\"EntityFlags\": {EntityFlags},");
			buffer.Append($"\"MoveType\": {MoveType}");
			buffer.Append("}");
		}
	}

	struct ReplayFrameOld
	{
		public Vector3 Position;
		public Vector2 EyeAngles;
		public Int32 Buttons;

		public static implicit operator ReplayFrame(ReplayFrameOld self)
		{
			ReplayFrame result = default;
			result.Position = self.Position;
			result.EyeAngles = self.EyeAngles;
			result.Buttons = self.Buttons;
			return result;
		}
	}
}
