namespace ConsoleApp1
{
    public static partial class Extensions
    {
        // Exercise 1.12
        public static uint PascalRecursive(int row, int column)
        {
            if (row == 0 && column == 0)
            {
                return 1;
            }

            if (column < 0 || column > row)
            {
                return 0;
            }

            return PascalRecursive(row - 1, column - 1) + PascalRecursive(row - 1, column);
        }
    }
}