using System;
namespace BeefLangStuff
{
	struct ReplayFrame
	{
		public Vector3 Position;
		public Vector2 EyeAngles;
		public int32 Buttons;
		public int32 EntityFlags;
		public int32 MoveType;

		public void ToJSONObject(String buffer)
		{
			buffer.Append("{");
			var temp = scope String();
			this.Position.ToJSONObject(temp);
			buffer.Append(scope $"\"Position\": {temp},");

			this.EyeAngles.ToJSONObject(temp);
			buffer.Append(scope $"\"EyeAngles\": {temp},");

			buffer.Append(scope $"\"Buttons\": {Buttons},");
			buffer.Append(scope $"\"EntityFlags\": {EntityFlags},");
			buffer.Append(scope $"\"MoveType\": {MoveType}");
			buffer.Append("}");
		}
	}

	struct ReplayFrameOld
	{
		public Vector3 Position;
		public Vector2 EyeAngles;
		public int32 Buttons;

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
