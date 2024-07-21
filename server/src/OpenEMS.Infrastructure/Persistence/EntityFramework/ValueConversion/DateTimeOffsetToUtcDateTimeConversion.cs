using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.ValueConversion;

public class DateTimeOffsetToUtcDateTimeConversion : ValueConverter<DateTimeOffset, DateTime>
{
    public DateTimeOffsetToUtcDateTimeConversion()
        : base(
            dateTimeOffset => dateTimeOffset.UtcDateTime,
            dateTime => new DateTimeOffset(dateTime, TimeSpan.Zero)
        ) { }
}
