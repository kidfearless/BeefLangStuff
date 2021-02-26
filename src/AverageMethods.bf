using System.Collections;
using System;
using System.Diagnostics;
namespace BeefLangStuff
{
	class AverageMethods
	{
		public static void Main()
		{
			Stopwatch watch = scope Stopwatch();
			watch.Start();
			float fSum = 280.0f;
			double dSum = 280.0;
			float averageSpeed = 280.0f;
			const int frames = 128 * 60 * 60 * 4;

			Console.WriteLine(scope $"Running for {frames} frames");

			for(int i = 1; i <= frames; i++)
			{
				var speed = gRand.NextDouble() * 1000.0;
				fSum += (float)speed;
				dSum += speed;
				averageSpeed += ((float)speed - averageSpeed) / i;
			}

			fSum /= (float)frames;
			dSum /= (double)frames;

			Console.WriteLine(scope $"Summedf Avg: {fSum}");
			Console.WriteLine(scope $"Summed  Avg: {dSum}");
			Console.WriteLine(scope $"Dynamic Avg: {averageSpeed}");
			watch.Stop();
			Console.WriteLine(scope $"Time Elapsed: {watch.Elapsed.TotalMilliseconds} milliseconds");
			Console.Read();
			// Results show that the third method is as accurate as summed doubles in most cases an
			// and in worst cases is only .3 off from the first method.

			// speed test shows:
			// 8ms to run this code in beef
			// 16ms to run this code in .NET 6
			// 24ms to run this code in .NET 5
		}
	}
}
