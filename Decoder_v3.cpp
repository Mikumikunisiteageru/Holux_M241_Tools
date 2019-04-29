#include<iostream>
#include<ctime>
// 20180601
// 20190429

int main (void) {
	FILE * fin, * fout;
	fin = fopen ("D:/Record/GPS_Logger/M241/Decoder/GPS.bin", "rb");
	if (fin == NULL) {
		printf ("Error Input!\n");
		return -1;
	}
	fout = fopen ("D:/Record/GPS_Logger/M241/Decoder/GPS.tsv", "w");
	if (fout == NULL) {
		printf ("Error Output!\n");
		return -1;
	}
	unsigned char block[65536];
	int n = 0, m = 0;
	do {
		fread (block, 1, 65536, fin);
		n ++;
		for (int p = 512; p <= 65516; p += 20) {
			unsigned int k = * ((unsigned int *) & (block[p]));
			if (0xFFFFFFFF == k)
				break;
			if (0xAAAAAAAA == k) {
				p -= 4;
				continue;
			}
			if (0x20202020 == * ((unsigned int *) & (block[p + 16])))
				continue;			
			// INDEX		
			m ++;
			fprintf (fout, "%d\t", m);		
			// DATE & TIME		
			// INT OVERFLOW OCCURED AT UTC+0
				// 2019-04-22T09:40:16
			// FIXED ON 2019-04-29
			if (k < 1073741824ll)
				k += 0x24EA0000;
			time_t t = k;
			struct tm *lt;
			lt = localtime (&t);
			char timestr[20];
			strftime (timestr, 20, "%Y-%m-%d,%H:%M:%S", lt);
			fprintf (fout, "%d\t%s\t", k, timestr);		
			// FLOATS		
			float latitude = * ((float *) & (block[p + 4])),
				 longitude = * ((float *) & (block[p + 8])),
				  altitude = * ((float *) & (block[p + 11])),
				  velocity = * ((float *) & (block[p + 15]));
			fprintf (fout, "%.6f\t%.6f\t%.1f\t%.3f\t", latitude, longitude, altitude, velocity);		
			// CHECKSUM		
			unsigned int c = 0;
			for (int i = p; i < p + 20; i ++)
				c ^= block[i];
			fprintf (fout, "%d\n", c);
		}
	} while (255 != block[0]);
	fclose (fin);
	fclose (fout);
	return 0;
}
