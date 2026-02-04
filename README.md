Quant-Lab

A structured quantitative research repository for systematic trading strategies.
The goal of this project is to ensure reproducibility, discipline, and clarity from research → backtesting → (eventually) execution.

📂 Repository Structure
Root files

README.md
Project overview, structure explanation, and usage instructions.

pyproject.toml / requirements.txt
Python dependencies and project configuration.

.gitignore
Prevents committing temporary files, environments, data, and artifacts.

.pre-commit-config.yaml
Code quality checks that run automatically before commits.

📁 docs/ — Research documentation & decisions

This folder is the research memory of the project.

research_log.md
Ongoing log of what was tested, observations, and next steps.

hypotheses/
One file per trading idea before coding.
Each hypothesis explains:

why an edge might exist

how it will be tested

failure modes

decisions/
Records of decisions after testing (accepted / rejected / iterated).
Prevents repeating the same mistakes.

datasets.md
Describes data sources, licenses, caveats, and preprocessing notes.
(Actual data is never stored in Git.)

📁 configs/ — Experiment configuration

All parameters live here so experiments are reproducible.

backtest_default.yaml
Global backtest assumptions (fees, slippage, capital, etc.).

strategies/
Strategy-specific parameters (lookbacks, thresholds, universes).

Code should not contain hard-coded parameters.

📁 src/ — Core source code

This is the engine room of the project.

src/data/ — Data ingestion & cleaning

ingest.py: load raw data from files/APIs

clean.py: handle missing data, alignment, adjustments

schema.py: define expected columns and validation rules

src/features/ — Feature engineering

Transforms clean data into numerical inputs for strategies.

transforms.py: basic calculations (returns, volatility, z-scores)

feature_sets.py: standardized collections of features

Features describe the market; they do not make trading decisions.

src/strategies/ — Strategy logic

Implements trading logic using features.

Strategies output signals or target positions

No data loading, pricing, or execution code here

src/backtest/ — Simulation & evaluation

Responsible for realistic backtesting.

engine.py: main backtest loop

costs.py: transaction cost & slippage models

metrics.py: performance statistics

walkforward.py: out-of-sample & rolling validation

src/risk/ — Risk management

Defines safety constraints.

limits.py: leverage, position, drawdown limits

checks.py: sanity checks before trades are allowed

Risk rules are enforced independently of strategy logic.

src/execution/ — Paper / live trading interface

Connects strategy output to brokers or simulators.

broker_interface.py: unified broker API wrapper

paper.py: paper-trading execution logic

src/utils/ — Shared utilities

Reusable helpers used across the project.

logging.py: consistent logging

hash_config.py: config/version hashing for reproducibility

📁 notebooks/ — Exploration only

Used for experimentation and visualization.

00_sandbox.ipynb: quick tests

01_feature_tests.ipynb: feature sanity checks

Final results must be reproducible via scripts, not notebooks.

📁 scripts/ — Runnable entry points

Command-line scripts to run the project.

make_dataset.py: build datasets

run_backtest.py: run a backtest

run_walkforward.py: run rolling validation

Each script should produce the same results when rerun.

📁 tests/ — Automated tests

Ensures correctness and prevents silent bugs.

test_data_sanity.py: data integrity checks

test_backtest_smoke.py: end-to-end backtest test

test_strategy_contracts.py: strategy interface checks

📁 artifacts/ — Outputs (not versioned)

Stores generated plots, reports, and results.

Not committed to Git

.gitkeep keeps the folder visible

🔁 Typical workflow

Write hypothesis (docs/hypotheses/)

Build data & features (src/data, src/features)

Implement strategy (src/strategies)

Backtest (src/backtest)

Record decision (docs/decisions)

Iterate or discard