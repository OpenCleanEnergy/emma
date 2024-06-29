namespace Emma.Application.Shared;

[AttributeUsage(
    AttributeTargets.Class | AttributeTargets.Interface,
    Inherited = true,
    AllowMultiple = false
)]
public sealed class RequiresTransactionAttribute : Attribute;
