TEX = xelatex -shell-escape
BIB = biber
MAIN = main
OUTPUT_DIR = output
BUILD_DIR = build
# STY_DIR = 

all: build clean-build clean-root output
	@echo "Build successful, PDF retained"

# 生成pdf，不构建bib
xelatex:
	@if not exist $(BUILD_DIR) mkdir $(BUILD_DIR)
	@if defined STY_DIR ( \
		set TEXMF_OUTPUT_DIRECTORY=$(BUILD_DIR) && $(TEX) -include-directory=$(STY_DIR) -output-directory=$(BUILD_DIR) $(MAIN).tex \
	) else ( \
		set TEXMF_OUTPUT_DIRECTORY=$(BUILD_DIR) && $(TEX) -output-directory=$(BUILD_DIR) $(MAIN).tex \
	)
	@echo "Build successful"

# 构建PDF并输出到build文件夹
build: 
	@if not exist $(BUILD_DIR) mkdir $(BUILD_DIR)
	@if defined STY_DIR ( \
		set TEXMF_OUTPUT_DIRECTORY=$(BUILD_DIR) && $(TEX) -include-directory=$(STY_DIR) -output-directory=$(BUILD_DIR) $(MAIN).tex \
	) else ( \
		set TEXMF_OUTPUT_DIRECTORY=$(BUILD_DIR) && $(TEX) -output-directory=$(BUILD_DIR) $(MAIN).tex \
	)
	@if exist $(BUILD_DIR)\$(MAIN).bcf ( \
		set TEXMF_OUTPUT_DIRECTORY=$(BUILD_DIR) && $(BIB) $(BUILD_DIR)/$(MAIN) \
	)
	@if exist $(BUILD_DIR)\$(MAIN).nlo ( \
		makeindex $(BUILD_DIR)/$(MAIN).nlo -s nomencl.ist -o $(BUILD_DIR)/$(MAIN).nls \
	)
	@if defined STY_DIR ( \
		set TEXMF_OUTPUT_DIRECTORY=$(BUILD_DIR) && $(TEX) -include-directory=$(STY_DIR) -output-directory=$(BUILD_DIR) $(MAIN).tex \
	) else ( \
		set TEXMF_OUTPUT_DIRECTORY=$(BUILD_DIR) && $(TEX) -output-directory=$(BUILD_DIR) $(MAIN).tex \
	)
	@if defined STY_DIR ( \
		set TEXMF_OUTPUT_DIRECTORY=$(BUILD_DIR) && $(TEX) -include-directory=$(STY_DIR) -output-directory=$(BUILD_DIR) $(MAIN).tex \
	) else ( \
		set TEXMF_OUTPUT_DIRECTORY=$(BUILD_DIR) && $(TEX) -output-directory=$(BUILD_DIR) $(MAIN).tex \
	)
	@echo "Build successful"
	
# 将build文件夹中的PDF复制到output文件夹，可选择自定义名称
output: 
	@if not exist $(BUILD_DIR)\$(MAIN).pdf ( \
		$(MAKE) build \
	)
	@if not exist $(OUTPUT_DIR) mkdir $(OUTPUT_DIR)
	@if "$(NAME)"=="" ( \
		copy $(BUILD_DIR)\$(MAIN).pdf $(OUTPUT_DIR)\$(MAIN).pdf \
	) else ( \
		copy $(BUILD_DIR)\$(MAIN).pdf $(OUTPUT_DIR)\$(NAME).pdf \
	)
	@if "$(NAME)"=="" ( \
		echo PDF file copied to $(OUTPUT_DIR)\$(MAIN).pdf \
	) else ( \
		echo PDF file copied to $(OUTPUT_DIR)\$(NAME).pdf \
	)

# 带时间统计的编译命令
cost-build:
	@echo "Starting timed compilation..."
	@powershell -Command " \
		$$start = Get-Date; \
		Invoke-Expression 'make build'; \
		$$end = Get-Date; \
		$$duration = ($$end - $$start).TotalSeconds; \
		Write-Output ('Compilation took {0:F2} seconds' -f $$duration) \
	"
	@echo "Timed build completed"


# 带时间统计的编译命令
cost-xelatex:
	@echo "Starting timed compilation..."
	@powershell -Command " \
		$$start = Get-Date; \
		Invoke-Expression 'make xelatex'; \
		$$end = Get-Date; \
		$$duration = ($$end - $$start).TotalSeconds; \
		Write-Output ('Compilation took {0:F2} seconds' -f $$duration) \
	"
	@echo "Timed build completed"

# 清理build目录中的辅助文件（但不删除PDF）
clean-build:
	@if exist $(BUILD_DIR)\*.aux del /Q $(BUILD_DIR)\*.aux
	@if exist $(BUILD_DIR)\*.toc del /Q $(BUILD_DIR)\*.toc
	@if exist $(BUILD_DIR)\*.out del /Q $(BUILD_DIR)\*.out
	@if exist $(BUILD_DIR)\*.log del /Q $(BUILD_DIR)\*.log
	@if exist $(BUILD_DIR)\*.bbl del /Q $(BUILD_DIR)\*.bbl
	@if exist $(BUILD_DIR)\*.bcf del /Q $(BUILD_DIR)\*.bcf
	@if exist $(BUILD_DIR)\*.blg del /Q $(BUILD_DIR)\*.blg
	@if exist $(BUILD_DIR)\*.run.xml del /Q $(BUILD_DIR)\*.run.xml
	@if exist $(BUILD_DIR)\*.listing del /Q $(BUILD_DIR)\*.listing
	@if exist $(BUILD_DIR)\*.synctex.gz del /Q $(BUILD_DIR)\*.synctex.gz
	@if exist $(BUILD_DIR)\*.ilg del /Q $(BUILD_DIR)\*.ilg
	@if exist $(BUILD_DIR)\*.nlo del /Q $(BUILD_DIR)\*.nlo
	@if exist $(BUILD_DIR)\*.nls del /Q $(BUILD_DIR)\*.nls
	@echo "Build directory cleaned"

# 清理项目根目录中的辅助文件
clean-root:
	@if exist *.aux del /Q *.aux
	@if exist *.toc del /Q *.toc
	@if exist *.out del /Q *.out
	@if exist *.log del /Q *.log
	@if exist *.bbl del /Q *.bbl
	@if exist *.bcf del /Q *.bcf
	@if exist *.blg del /Q *.blg
	@if exist *.run.xml del /Q *.run.xml
	@if exist *.listing del /Q *.listing
	@if exist *.synctex.gz del /Q *.synctex.gz
	@if exist *.ilg del /Q *.ilg
	@if exist *.nlo del /Q *.nlo
	@if exist *.nls del /Q *.nls
	@echo "Root directory cleaned"


# 清理build目录和根目录中的所有临时文件，并删除PDF文件
clean-all: clean
	@if exist $(BUILD_DIR)\$(MAIN).pdf ( \
		del /Q $(BUILD_DIR)\$(MAIN).pdf || true \
	)
	@if exist $(MAIN).pdf ( \
		del /Q $(MAIN).pdf || true \
	)
	@echo "Completely cleaned"

clean: clean-build clean-root
	@echo "Cleaned $(CURDIR) and $(BUILD_DIR)"

.PHONY: xelatex build clean-root clean-build output clean-all cost-build cost-xelatex
