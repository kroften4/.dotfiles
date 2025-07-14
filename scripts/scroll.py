import click
import time
import subprocess

def get_cmd_output(command):
    return subprocess.check_output(command, shell=True).decode().replace('\n', '')

def get_scrolled_msg(string, separator, length, scroll_index):
    message = (string + separator) * 2
    scroll_index %= len(string + separator)
    return message[scroll_index:scroll_index + length]


@click.command()
@click.option('--scroll-interval', default=1)
@click.option('--exec', prompt='Command to get output from')
@click.option('--max-length', default=30)
@click.option('--separator', default=' ')
def scroll(scroll_interval, exec, max_length, separator):
    scroll_index = 0
    cmd_output = get_cmd_output(exec);
    length = len(cmd_output)
    scroll = len(cmd_output) > max_length
    if scroll:
        length = max_length
    while True:
        new_cmd_ouput = get_cmd_output(exec)
        if cmd_output != new_cmd_ouput:
            scroll_index = 0
            cmd_output = new_cmd_ouput
            length = len(cmd_output)
            scroll = len(cmd_output) > max_length
            if scroll:
                length = max_length

        message = get_scrolled_msg(cmd_output, separator, length, scroll_index)
        if scroll:
            scroll_index += 1
        click.echo(message[:length])
        time.sleep(scroll_interval)

if __name__ == "__main__":
    scroll()
