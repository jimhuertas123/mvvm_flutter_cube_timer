# PRINCIPAL Audit Report

**Generated:** 2026-01-22 11:16:59
**Tool:** optix-mcp-server principal_audit
**Project:** mvvm_flutter_cube_timer

## Executive Summary

<!-- PLACEHOLDER: Executive Summary -->

{Brief 2-3 sentence narrative describing what was audited and key outcomes}

| Metric | Value |
|--------|-------|
| Total Issues | {N} |
| Critical | {N} |
| High | {N} |
| Medium | {N} |
| Low | {N} |
| Files Examined | {N} |
| Overall Status | **{PASS/NEEDS_ATTENTION/CRITICAL}** |

### Risk Distribution

```
Critical ██░░░░░░░░  {N} ({%})
High     ███░░░░░░░  {N} ({%})
Medium   ████░░░░░░  {N} ({%})
Low      █████░░░░░  {N} ({%})
```

## Code Health Score

<!-- PLACEHOLDER: Code Health Score -->

**Overall Score:** {N} / 100

```
Code Health  ████████░░  {N}/100

Complexity   ██████░░░░  {score}/100
DRY          ████████░░  {score}/100
Coupling     ███████░░░  {score}/100
SoC          █████░░░░░  {score}/100
```

| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| Avg Cyclomatic Complexity | {N} | <10 | ✅/⚠️/❌ |
| Max Cyclomatic Complexity | {N} | <15 | ✅/⚠️/❌ |
| Code Duplication | {N}% | <5% | ✅/⚠️/❌ |
| Coupling Score (Avg) | {N} | <0.3 | ✅/⚠️/❌ |
| Maintainability Index | {N} | >65 | ✅/⚠️/❌ |
| Lines of Code | {N} | - | ℹ️ |

## Metrics Distribution

<!-- PLACEHOLDER: Metrics Distribution -->

| Category | Issues | Files Affected |
|----------|--------|----------------|
| High Complexity | {N} | {list of files} |
| Code Duplication | {N} | {list of files} |
| High Coupling | {N} | {list of files} |
| Mixed Responsibilities | {N} | {list of files} |

## Findings

<!-- PLACEHOLDER: Findings -->

### Critical (Immediate Refactor Required)

#### {N}. {Issue Title}

**File:** `{filepath}:{line}`
**Category:** {Complexity/DRY/Coupling/SoC}
**Metric Value:** {measured value} (Threshold: {threshold})

```{language}
{code snippet showing the issue}
```

**Impact:** {description of maintainability/quality impact}

**Remediation:**
```{language}
{refactored code or pseudocode showing improvement}
```

---

_Or if no critical findings:_ **No critical code quality issues found.**

### High (Technical Debt)

#### {N}. {Issue Title}

**File:** `{filepath}:{line}`
**Category:** {Complexity/DRY/Coupling/SoC}
**Metric Value:** {measured value} (Threshold: {threshold})

```{language}
{code snippet showing the issue}
```

**Impact:** {description of maintainability/quality impact}

**Remediation:**
```{language}
{refactored code or pseudocode showing improvement}
```

---

_Or if no high findings:_ **No high severity issues found.**

### Medium (Improvement Recommended)

#### {N}. {Issue Title}

**File:** `{filepath}:{line}`
**Category:** {Complexity/DRY/Coupling/SoC}
**Metric Value:** {measured value} (Threshold: {threshold})

```{language}
{code snippet showing the issue}
```

**Impact:** {description of maintainability/quality impact}

**Remediation:**
```{language}
{refactored code or pseudocode showing improvement}
```

---

_Or if no medium findings:_ **No medium severity issues found.**

### Low (Best Practice Suggestions)

#### {N}. {Issue Title}

**File:** `{filepath}:{line}`
**Category:** {Complexity/DRY/Coupling/SoC}
**Metric Value:** {measured value} (Threshold: {threshold})

```{language}
{code snippet showing the issue}
```

**Impact:** {description of maintainability/quality impact}

**Remediation:**
```{language}
{refactored code or pseudocode showing improvement}
```

---

_Or if no low findings:_ **No low severity issues found.**

## Positive Findings

<!-- PLACEHOLDER: Positive Findings -->

| Good Practice | Location | Assessment |
|---------------|----------|------------|
| {pattern/practice} | `{file path}` | {why it's good} |
| {pattern/practice} | `{file path}` | {why it's good} |

_List well-designed modules, good patterns, clean code examples._

## Complexity Hotspots

<!-- PLACEHOLDER: Complexity Hotspots -->

| Function/Method | File | Complexity | LOC | Risk |
|-----------------|------|------------|-----|------|
| `{function_name}` | `{file}:{line}` | {N} | {N} | ⚠️/❌ |
| `{function_name}` | `{file}:{line}` | {N} | {N} | ⚠️/❌ |

_Functions with cyclomatic complexity > 10 are listed as hotspots._

## Duplication Analysis

<!-- PLACEHOLDER: Duplication Analysis -->

| Clone Type | Instances | Files | Lines Duplicated |
|------------|-----------|-------|------------------|
| Type 1 (Exact) | {N} | {files} | {N} |
| Type 2 (Renamed) | {N} | {files} | {N} |
| Type 3 (Modified) | {N} | {files} | {N} |

### Significant Duplications

1. **{description}**
   - Files: `{file1}`, `{file2}`
   - Lines: ~{N} duplicated lines
   - Recommendation: {extract to shared module/function}

## Module Dependency Graph

<!-- PLACEHOLDER: Module Dependency Graph -->

```
┌─────────────────────────────────────────────────────────────┐
│                    Module Dependencies                       │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────┐                                               │
│  │  Module  │───▶ {N} dependencies                          │
│  │    A     │◀─── {N} dependents                            │
│  └──────────┘                                               │
│       │                                                      │
│       ▼                                                      │
│  ┌──────────┐    ┌──────────┐                               │
│  │  Module  │───▶│  Module  │                               │
│  │    B     │    │    C     │                               │
│  └──────────┘    └──────────┘                               │
└─────────────────────────────────────────────────────────────┘

{Replace with actual dependency visualization}
```

| Module | Afferent (In) | Efferent (Out) | Instability |
|--------|---------------|----------------|-------------|
| {module} | {N} | {N} | {0.0-1.0} |

_This section is optional. Include if coupling analysis was performed._

## Files Examined

<!-- PLACEHOLDER: Files Examined -->

### Core Modules
- `{file path}`

### Business Logic
- `{file path}`

### Data Access
- `{file path}`

### Utilities
- `{file path}`

### Tests
- `{file path}`

## Remediation Priority

<!-- PLACEHOLDER: Remediation Priority -->

### Immediate (P0) - High Complexity Functions
1. {action item with reference to finding number}
2. {action item}

### Short-term (P1) - Code Duplication
3. {action item with reference to finding number}
4. {action item}

### Medium-term (P2) - Architectural Improvements
5. {action item with reference to finding number}
6. {action item}

## Refactoring Recommendations

<!-- PLACEHOLDER: Refactoring Recommendations -->

### Extract Method/Function
- `{location}`: Extract {description} into separate function

### Extract Module/Class
- `{location}`: Move {functionality} to dedicated module

### Apply Design Pattern
- `{location}`: Consider {pattern name} for {reason}

### Dependency Inversion
- `{location}`: Introduce interface for {dependency}

_Prioritize refactoring based on finding severity and business impact._

---

*This report was generated automatically by optix-mcp-server principal_audit tool.
For questions or concerns, please contact your development team.*