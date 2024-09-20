# Bash Markdown Table Gerenator

A simple markdown generator I made for my own needs, I intend on expanding its capabilities further in the close future.
<hr>

### <b>Current features and limitations (20/09/2024)</b>
- Generates a markdown table with N columns and rows
- Outputs the generated table to the terminal
- Automatically centers all columns and rows contents
- Hardcoded row and column variable (must be edited everytime a table needs to be generated)
- No unit tests

### <b>Planned improvements</b>
- Auto formatter 
    - The outputted table will be automatically formatted to be human readable
    - This can be used as a separate feature (table formatter)
- Customizable position
    - The generator should accept a position parameter instead of always centralizing the entire table
- Input from file
    - The generator should accept a set of files extensions as the input
        - CSV, JSON, Custom extension
- Interactive CLI

<hr>

### <b>How to use it</b>
1. Clone the `table-generator.sh` file on `./README.md`
2. Customize the `raw_columns` and `raw_rows` variables

    - `raw_columns` are the table headers separated by `:`
    - `raw_rows` are each row's content in the same order as `raw_columns`
        - Each row must start with `-`
        - Each row column must be separated by `:`
        - The amount of row columns must be equal to the amount of header columns

3. Run `bash table-generator.sh` on the terminal
4. Copy the console output
5. Profit!