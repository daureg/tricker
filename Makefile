.PHONY: pyright local-tests clean ty ruff deptry
pyright:
	pyright --pythonpath .venv/bin/python3

local-tests:
	uv run --no-sync pytest -W ignore::DeprecationWarning --cov-report html

clean:
	fd -t f -uu -H pyc -X rm && fd -0 -t d -uu __pycache__ -X rmdir
	rm -rf .ruff_cache/ .pytest_cache/ htmlcov/ .coverage* xunit-reports/ coverage-reports/ dist/

ty:
	uv run --no-sync --offline ty check src/ tests/

deptry:
	uv run --no-sync --offline deptry .

ruff:
	git ls-files '*.py' | xargs uv run --no-sync --with ruff ruff check --output-format concise

lint: deptry ty pyright ruff
