FROM vipintm/xelatex
WORKDIR /app
COPY . /app
CMD ["./Compile_All.sh"]