using System;
using System.Collections;
namespace BeefLangStuff
{
	class ShavitReplay
	{
		public int Version;
		public uint8 Style;
		public uint8 Track;
		public int32 PreFrames;
		public int32 FrameCount;
		public int32 SteamID;
		public float Time;



		protected List<ReplayFrame> frames;
		protected bool IsFramesScoped = false;
		protected String format;
		protected bool IsFormatScoped = false;
		protected String map;
		protected bool IsMapScoped = false;

		public void SetFrames(List<ReplayFrame> frame, bool isScoped = true)
		{
			this.Frames = frame;
			this.IsFramesScoped = isScoped;
		}

		public void SetMap(String map, bool isScoped = true)
		{
			this.Map = map;
			this.IsMapScoped = isScoped;
		}

		public void SetFormat(String head, bool isScoped = true)
		{
			this.Format = head;
			this.IsFormatScoped = isScoped;
		}

		public List<ReplayFrame> Frames
		{
			get
			{
				return frames;
			}
			protected set
			{
				frames = value;
			}
		}

		public String Map
		{
			get
			{
				return map;
			}
			protected set
			{
				map = value;
			}
		}

		public String Format
		{
			get
			{
				return format;
			}
			protected set
			{
				format = value;
			}
		}


		public this()
		{
		}



		public ~this()
		{
			if(!this.IsFormatScoped && Format != null)
			{
				delete Format;
			}
			if(!this.IsFramesScoped && Frames != null)
			{
				delete Frames;
			}
			if(!this.IsMapScoped && Map != null)
			{
				delete Map;
			}
		}
	}
}
