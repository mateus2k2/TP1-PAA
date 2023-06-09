#make -s --> Suppresses other makefile messages

all: driver.o insertionSort.o mergeSort.o radixSort.o 
	@gcc ./src/obj/driver.o ./src/obj/insertionSort.o ./src/obj/mergeSort.o ./src/obj/radixSort.o -o ./bin/runner.exe -Wall

degub: 
	@gcc ./src/*.c -o ./bin/degub.exe -g

degubRun:
	@gdb ./bin/degub.exe

# ------------------------------------------------------------------------------

driver.o: ./src/driver.c
	@gcc -c ./src/driver.c -o ./src/obj/driver.o -Wall

insertionSort.o: ./src/insertionSort.c
	@gcc -c ./src/insertionSort.c -o ./src/obj/insertionSort.o -Wall

mergeSort.o: ./src/mergeSort.c
	@gcc -c ./src/mergeSort.c -o ./src/obj/mergeSort.o -Wall

radixSort.o: ./src/radixSort.c
	@gcc -c ./src/radixSort.c -o ./src/obj/radixSort.o -Wall

# ------------------------------------------------------------------------------

run:
	@./bin/runner.exe $(SIZE) >> ./output/output.csv

testes:
	@bash ./scripts/runTests.sh
	@make -s t

# usado o output.csv para gera as medias para cada tamnho de instancia >> averege.csv
media:
	@cd ./statistic && python average.py && cd ./.. 

# usando o arquivo averege.csv para gerar os graficos em barra
barra:
	@cd ./statistic && python barGraphs.py && cd ./..

# usando o arquivo averege.csv para gerar os graficos em linha
linha:
	@cd ./statistic && python lineGraphs.py && cd ./..

# usando o arquivo IntervaloMedia.csv para gerar os graficos de confianca
confianca:
	@cd ./statistic && python confidenceGraph.py && cd ./..

# usado o output.csv para gera o intervalo de confianca e a diferenca das medias >> IntervaloMedia.csv
testeT:
	@cd ./statistic && python tTeste.py >> ../output/IntervaloMedia.csv && cd ./..

images:
	@cd ./statistic && python images.py && cd ./..


# t:	
# 	@cd ./output && rm ./*.out && cd ./..
# 	@cd ./statistic && python tTeste.py >> ../output/resultados.out && cd ./..
# ------------------------------------------------------------------------------

go:
	@make -s clean
	@make -s all
	@make -s run

# ------------------------------------------------------------------------------

clean:
	# @cd ./bin && rm ./*.exe 
	# @cd ./src/obj && rm ./*.o
	# @clear
