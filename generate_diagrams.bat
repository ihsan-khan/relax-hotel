@echo off
echo Installing Mermaid CLI for diagram export...
npm install -g @mermaid-js/mermaid-cli

echo.
echo Generating PNG diagram...
mmdc -i DATABASE_DIAGRAM.md -o hotel_database_schema.png

echo.
echo Generating SVG diagram...
mmdc -i DATABASE_DIAGRAM.md -o hotel_database_schema.svg

echo.
echo Done! Check the generated files:
echo - hotel_database_schema.png
echo - hotel_database_schema.svg

pause