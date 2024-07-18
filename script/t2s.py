from sys import argv
import os
import opencc

converter = opencc.OpenCC('t2s')
t2s = lambda text: converter.convert(text)  # 文档汉字简化函数

def change_file(filename):  # 简化一个文件中的汉字
    s = ""
    with open(filename, "r") as f:
        s = f.read()
    s = t2s(s)
    with open(filename, "w") as f:
        f.write(s)

def dfs(path, do=change_file):  # 简单地深度优先搜索目录下所有文件
    if os.path.isdir(path):
        l = os.listdir(path)
        for i in l:
            dfs(i)
    elif os.path.isfile(path):
        do(path)
    else:
        print('"%s" does not exist.'%path)

def main():
    del argv[0]
    if len(argv) == 0:
        exit(1)
    for i in argv:
        dfs(i)

if __name__ == "__main__":
    main()
