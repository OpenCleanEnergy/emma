using NSubstitute;
using OpenEMS.Application.Shared.Identity;

namespace OpenEMS.Infrastructure.Test;

public class TestDbContextFixture : IAsyncLifetime
{
    private TestDbContext? _context;

    public async Task DisposeAsync()
    {
        if (_context is not null)
        {
            await _context.DisposeAsync();
        }
    }

    public async Task InitializeAsync()
    {
        _context = await TestDbContext.CreateNew(Substitute.For<ICurrentUserReader>());
    }

    public TestDbContext CreateNewContext(ICurrentUserReader? currentUserReader = null)
    {
        return TestDbContext.FromExisting(
            _context
                ?? throw new InvalidOperationException($"Call {nameof(InitializeAsync)} first."),
            currentUserReader
        );
    }
}
