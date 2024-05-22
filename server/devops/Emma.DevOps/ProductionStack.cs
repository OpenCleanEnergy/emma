using Pulumi;

namespace Emma.DevOps;

public class ProductionStack : Stack
{
    public ProductionStack()
    {
        Result = Output.Create(true);
    }

    [Output("result")]
    public Output<bool> Result { get; }
}
