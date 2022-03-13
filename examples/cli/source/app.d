import std.stdio;
import sparkline.sparkline: sparkline;
import std.conv : to;
import std.array;

void main(string[] argv)
{
	auto doubleBuilder = appender!(double[]);
	const length = argv.length > 1 ? argv.length + -1 : 0;
	doubleBuilder.reserve(length);
	for(int i = 1; i < argv.length; i++) {
		doubleBuilder.put(to!double(argv[i]));
	}
	auto text = sparkline(doubleBuilder.data);
	writeln(text);
}
