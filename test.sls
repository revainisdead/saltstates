touch /home/christian/test.txt:
    cmd.run:
        - creates: /home/christian/test.txt

/home/christian/test.txt:
    file.append:
        - text: |
            this is a sentence
