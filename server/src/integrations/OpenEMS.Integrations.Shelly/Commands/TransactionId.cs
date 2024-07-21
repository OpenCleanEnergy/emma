using Vogen;

namespace OpenEMS.Integrations.Shelly.Commands;

[ValueObject<int>(comparison: ComparisonGeneration.Omit)]
public readonly partial record struct TransactionId
{
    private const int InitialTransactionId = 10;
    private static readonly object _lock = new();
    private static int _transactionId = InitialTransactionId;

    public static TransactionId Next()
    {
        lock (_lock)
        {
            _transactionId += 1;
            if (_transactionId >= 10000)
            {
                _transactionId = InitialTransactionId;
            }

            return From(_transactionId);
        }
    }
}
