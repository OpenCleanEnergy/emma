using System.Diagnostics.CodeAnalysis;
using System.Globalization;
using System.Text.RegularExpressions;

namespace OpenEMS.Pipeline.Targets.Docker;

internal sealed record NodePackage(string Version);
