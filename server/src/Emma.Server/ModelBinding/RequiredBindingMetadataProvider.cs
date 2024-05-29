using Microsoft.AspNetCore.Mvc.ModelBinding.Metadata;

namespace Emma.Server.ModelBinding;

/// <summary>
/// Fixes S6964: Property used as input in a controller action should be nullable or annotated with the Required attribute to avoid under-posting.
/// <para>
/// See https://rules.sonarsource.com/csharp/RSPEC-6964 and https://thom.ee/blog/clean-way-to-use-required-value-types-in-asp-net-core/.
/// </para>
/// </summary>
public class RequiredBindingMetadataProvider : IBindingMetadataProvider
{
    public void CreateBindingMetadata(BindingMetadataProviderContext context)
    {
        if (context.BindingMetadata.IsBindingRequired)
        {
            // Binding is already required. We're good.
            return;
        }

        var modelType = context.Key.ModelType;
        var isValueType = modelType.IsValueType;
        var isNullable = Nullable.GetUnderlyingType(modelType) is not null;

        if (isValueType && !isNullable)
        {
            // Binding is required for non-nullable value types.
            context.BindingMetadata.IsBindingRequired = true;
        }
    }
}
