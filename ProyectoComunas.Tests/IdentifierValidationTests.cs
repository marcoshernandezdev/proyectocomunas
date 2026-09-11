using Xunit;

namespace ProyectoComunas.Tests;

public static class IdentifierValidation
{
    public static bool IsValidId(int id) => id > 0;
}

public class IdentifierValidationTests
{
    [Theory]
    [InlineData(1, true)]
    [InlineData(0, false)]
    [InlineData(-5, false)]
    public void IsValidId_WorksAsExpected(int id, bool expected)
    {
        Assert.Equal(expected, IdentifierValidation.IsValidId(id));
    }
}
