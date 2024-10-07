namespace OpenEMS.Infrastructure.Analytics.Samples;

public interface IDbContextDeviceSamplingSqlFactory
{
    string GetSamplingSql(Func<Type, string> tableNameProvider, string timestampParam);
}
