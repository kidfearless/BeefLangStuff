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



		protected List<ReplayFrame> frames;
		protected bool IsFramesScoped = false;
		protected String header;
		protected bool IsHeaderScoped = false;
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

		public void SetHeader(String head, bool isScoped = true)
		{
			this.Header = head;
			this.IsHeaderScoped = isScoped;
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

		public String Header
		{
			get
			{
				return Header;
			}
			protected set
			{
				header = value;
			}
		}


		public this()
		{
		}



		public ~this()
		{
			if(!this.IsHeaderScoped)
			{
				delete Header;
			}
			if(!this.IsFramesScoped)
			{
				delete Frames;
			}
			if(!this.IsMapScoped)
			{
				delete Map;
			}
		}
	}
}
