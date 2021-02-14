using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace BeefLangStuff
{
	class ShavitReplay
	{
		public int Version;
		public byte Style;
		public byte Track;
		public Int32 PreFrames;
		public Int32 FrameCount;
		public Int32 SteamID;
		public float Time;



		protected List<ReplayFrame> frames;
		protected bool IsFramesScoped = false;
		protected string format;
		protected bool IsFormatScoped = false;
		protected string map;
		protected bool IsMapScoped = false;

		public void SetFrames(List<ReplayFrame> frame, bool isScoped = true)
		{
			this.Frames = frame;
			this.IsFramesScoped = isScoped;
		}

		public void SetMap(string map, bool isScoped = true)
		{
			this.Map = map;
			this.IsMapScoped = isScoped;
		}

		public void SetFormat(string head, bool isScoped = true)
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
			set
			{
				frames = value;
			}
		}

		public string Map
		{
			get
			{
				return map;
			}
			set
			{
				map = value;
			}
		}

		public string Format
		{
			get
			{
				return format;
			}
			set
			{
				format = value;
			}
		}


		public ShavitReplay()
		{
		}



		~ShavitReplay()
		{
			if(!this.IsFormatScoped && Format != null)
			{
				Format = null;
			}
			if(!this.IsFramesScoped && Frames != null)
			{
				Frames = null;
			}
			if(!this.IsMapScoped && Map != null)
			{
				Map = null;
			}
		}
	}
}
