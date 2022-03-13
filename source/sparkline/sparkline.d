module sparkline.sparkline;

import std.algorithm : max, min;
import std.math.rounding : floor;
import std.array;

/**
 * Generates sparkline string given arrray of numbers
 */
public string sparkline(const double[] numbers, wchar[] steps = [
        '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'
    ])
{
    if (numbers.length == 0)
    {
        return "";
    }
    import std.numeric: normalize;

    double minVal = numbers[0];
    double maxVal = numbers[0];
    const sLen = steps.length;
    for (int i = 0; i < numbers.length; i++)
    {
        minVal = min(minVal, numbers[i]);
        maxVal = max(maxVal, numbers[i]);
    }
    auto strBuilder = appender!string;
    for (int i = 0; i < numbers.length; i++)
    {
        if (minVal == maxVal)
        {
            strBuilder.put(steps[0]);
            continue;
        }
        int x = cast(int)(((numbers[i] - minVal) / (maxVal - minVal)) * (sLen - 1));
        strBuilder.put(steps[x]);
    }
    return strBuilder.data;
}

unittest
{
    assert(sparkline([1.0, 2.0, 3.0]) == "▁▄█");
    assert(sparkline([67, 71, 77, 85, 95, 104, 106, 105, 100, 89, 76, 66]) == "▁▁▂▄▆▇█▇▆▅▂▁");
    assert(sparkline([1.1, 0.1, 0.1, 1.1]) == "█▁▁█");
    assert(sparkline([1, 1, 1, 1, 1]) == "▁▁▁▁▁", "works with all values being equal");
    assert(sparkline([], []) == "", "works with no values");
    assert(sparkline([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
            ]) == "0123456789", "works with custom steps");
}
