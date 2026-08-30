
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SPCtools

SPCtools is an R package for clear and reproducible statistical process
control calculations. It provides opinionated and human readable
functions for XmR, XbarR, ANOX, and ANOM analyses that support real
operational use in manufacturing, R&D, and industrial statistics.

The package emphasizes:

- **Correct calculations**. SPCtools includes tests and edge case
  handling to ensure accurate limits and diagnostics across a wide range
  of data scenarios.
- **Reproducible workflows**. Functions return structured objects that
  contain metadata about how limits were calculated, what baseline data
  was used, and why. This supports documentation, auditability, and
  enterprise level long term monitoring.
- **Clarity over complexity**. SPC calculations are not computationally
  heavy, so SPCtools prioritizes readable code, minimal dependencies,
  and transparent logic.
- **Practical extensions**. In addition to standard control charts,
  SPCtools includes ANOX and ANOM methods for fixed datasets, which
  support intuitive diagnostics and exploratory analysis beyond ongoing
  monitoring.

## Design philosophy: primitives and rich functions

SPCtools uses a **two layer design**.

- **Primitives**. These are small and dependency free functions that
  perform the core SPC calculations such as XmR, XbarR, ANOX, and ANOM.
  They are stable, testable, and reusable in any workflow or downstream
  tool.

- **Rich functions**. These are **higher level helpers** that call the
  primitives and return structured objects that include metadata, notes,
  baseline summaries, and other information needed for documentation,
  reproducibility, and ongoing monitoring.

This separation keeps the core calculations clear and auditable while
providing a richer workflow for real operational use. The primitives can
be reused in other packages, pipelines, or applications. The rich
functions support disciplined SPC practice in regulated environments.

## Why SPCtools

I have used SPC methods for many years in manufacturing, R&D, and
industrial analytics. Control charts are powerful tools for
understanding variation, diagnosing problems, and guiding decisions.
They are also essential prerequisites for many analyses, especially when
data may show patterns over time, across batches, or during experiments.

Existing R packages sometimes produce inconsistent results or lack the
workflow structure needed for documentation and reproducibility.
SPCtools aims to provide:

- disciplined and correct calculations
- metadata rich outputs
- opinionated defaults that reflect real world usage
- extensions for ANOX and ANOM
- a foundation for future SPC related utilities
- a clear view into how I approach SPC problems and systems design

## Installation

You can install the development version of SPCtools from GitHub.

``` r
# install.packages("devtools")
# devtools::install_github("benjepson/SPCtools")
```

## Examples

Examples and vignettes are in development as the core functions and
tests are completed. A pkgdown documentation site will be available
soon.

## Roadmap

- XmR and XbarR calculations with metadata
- XmR is what I find most useful, so it is the first priority
- Rare‑events XmR support
- ANOX and ANOM functions (analogues of XmR and XbarR for one time
  analysis vs. ongoing monitoring)
- Workflow helpers for documentation and reproducibility
- Comprehensive test suite for edge‑case scenarios
- pkgdown site with examples and guidance
