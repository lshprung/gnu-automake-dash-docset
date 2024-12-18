SRC_ICON_FILE = $(SOURCE_DIR)/icon.png
INDEX_ENTRY_CLASS=printindex-index-entry

MANUAL_URL  = https://www.gnu.org/software/automake/manual/automake.html_node.tar.gz
MANUAL_FILE = tmp/automake.html_node.tar.gz

$(MANUAL_FILE): tmp
	curl -o $@ $(MANUAL_URL)

$(DOCUMENTS_DIR): $(RESOURCES_DIR) $(MANUAL_FILE)
	mkdir -p $@
	tar -x -z -f $(MANUAL_FILE) -C $@

$(INDEX_FILE): $(SOURCE_DIR)/src/index-pages.sh $(SCRIPTS_DIR)/gnu/index-terms-class.sh $(DOCUMENTS_DIR)
	rm -f $@
	$(SOURCE_DIR)/src/index-pages.sh $@ $(DOCUMENTS_DIR)/*.html
	$(SCRIPTS_DIR)/gnu/index-terms-class.sh "Macro"    $(INDEX_ENTRY_CLASS) $@ $(DOCUMENTS_DIR)/Macro-Index.html
	$(SCRIPTS_DIR)/gnu/index-terms-class.sh "Variable" $(INDEX_ENTRY_CLASS) $@ $(DOCUMENTS_DIR)/Variable-Index.html
	$(SCRIPTS_DIR)/gnu/index-terms-class.sh "Entry"    $(INDEX_ENTRY_CLASS) $@ $(DOCUMENTS_DIR)/General-Index.html
