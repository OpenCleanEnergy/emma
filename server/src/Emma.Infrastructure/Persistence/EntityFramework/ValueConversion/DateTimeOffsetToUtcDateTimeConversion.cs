using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace Emma.Infrastructure.Persistence.EntityFramework.ValueConversion;

public class DateTimeOffsetToUtcDateTimeConversion : ValueConverter<DateTimeOffset, DateTime>
{
    public DateTimeOffsetToUtcDateTimeConversion()
        : base(
            dateTimeOffset => dateTimeOffset.UtcDateTime,
            dateTime => new DateTimeOffset(dateTime, TimeSpan.Zero)
        ) { }
}
