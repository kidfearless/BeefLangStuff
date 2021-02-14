using System;
using System.IO;

namespace BeefLangStuff
{
	class Program2
	{
		public static void Main(String[] args)
		{
			String inputFile = scope String(256);
			String outputFile = scope String(256);
			GetFileLocations(ref inputFile, ref outputFile);
			ShavitReplay replay = scope ShavitReplay();

			FileStream stream = scope FileStream()


			// get the input and output of the file if it was passed through command line
		}

		static void GetFileLocations(ref String inputFile, ref String outputFile)
		{
			OpenFileDialog dialog = scope OpenFileDialog();

			dialog.Title = "Select Input File";
			Result<DialogResult> result = dialog.ShowDialog();

			while (result.Value != DialogResult.OK)
			{
				dialog.ShowDialog();
			}
			inputFile = scope:: String(dialog.FileNames[0]);

			dialog.Title = "Select Destination File";
			dialog.Reset();

			result.Dispose();
			result = dialog.ShowDialog();
			while (result.Value != DialogResult.OK)
			{
				dialog.ShowDialog();
			}
			outputFile = scope:: String(dialog.FileNames[0]);
			dialog.Reset();
			result.Dispose();
		}
	}
}