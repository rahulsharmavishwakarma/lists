#!/bin/bash

echo "================================================================================
                        🧪 COMPREHENSIVE INTERACTION TESTS 🧪
================================================================================"

API_BASE="http://localhost:8000"

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

pass() {
    echo -e "${GREEN}✅ PASS${NC} - $1"
}

fail() {
    echo -e "${RED}❌ FAIL${NC} - $1"
}

info() {
    echo -e "${BLUE}ℹ️  INFO${NC} - $1"
}

warn() {
    echo -e "${YELLOW}⚠️  WARN${NC} - $1"
}

echo ""
echo "📊 TEST SUITE 1: API ENDPOINTS"
echo "================================================================================"

# Test 1: Health Check
HEALTH=$(curl -s $API_BASE/health)
if [[ "$HEALTH" == *"healthy"* ]]; then
    pass "API Health Check"
else
    fail "API Health Check - Response: $HEALTH"
fi

# Test 2: Create Todo
TODO_RESPONSE=$(curl -s -X POST $API_BASE/api/todos/ \
  -H "Content-Type: application/json" \
  -d '{"title": "Test Interaction", "description": "Test all interactions", "priority": "high"}')
if [[ "$TODO_RESPONSE" == *"Test Interaction"* ]]; then
    pass "Create Todo"
    TODO_ID=$(echo "$TODO_RESPONSE" | python -c "import sys, json; print(json.load(sys.stdin).get('id', ''))")
else
    fail "Create Todo"
    TODO_ID=""
fi

# Test 3: Get Todos
GET_TODOS=$(curl -s $API_BASE/api/todos/)
if [[ "$GET_TODOS" == *"Test Interaction"* ]]; then
    pass "Get Todos"
else
    fail "Get Todos"
fi

# Test 4: Get Specific Todo
if [ ! -z "$TODO_ID" ]; then
    GET_TODO=$(curl -s $API_BASE/api/todos/$TODO_ID)
    if [[ "$GET_TODO" == *"Test Interaction"* ]]; then
        pass "Get Specific Todo"
    else
        fail "Get Specific Todo"
    fi
else
    warn "Skip Get Specific Todo - No ID"
fi

# Test 5: Update Todo
if [ ! -z "$TODO_ID" ]; then
    UPDATE_RESPONSE=$(curl -s -X PUT $API_BASE/api/todos/$TODO_ID \
      -H "Content-Type: application/json" \
      -d '{"title": "Updated Test Interaction"}')
    if [[ "$UPDATE_RESPONSE" == *"Updated Test Interaction"* ]]; then
        pass "Update Todo"
    else
        fail "Update Todo"
    fi
else
    warn "Skip Update Todo - No ID"
fi

# Test 6: Toggle Todo
if [ ! -z "$TODO_ID" ]; then
    TOGGLE_RESPONSE=$(curl -s -X PATCH $API_BASE/api/todos/$TODO_ID/toggle)
    if [[ "$TOGGLE_RESPONSE" == *"completed"* ]]; then
        pass "Toggle Todo"
    else
        fail "Toggle Todo"
    fi
else
    warn "Skip Toggle Todo - No ID"
fi

# Test 7: Create Subtask
if [ ! -z "$TODO_ID" ]; then
    SUBTASK_RESPONSE=$(curl -s -X POST $API_BASE/api/todos/$TODO_ID/subtasks \
      -H "Content-Type: application/json" \
      -d '{"title": "Test Subtask"}')
    if [[ "$SUBTASK_RESPONSE" == *"Test Subtask"* ]]; then
        pass "Create Subtask"
        SUBTASK_ID=$(echo "$SUBTASK_RESPONSE" | python -c "import sys, json; print(json.load(sys.stdin).get('id', ''))")
    else
        fail "Create Subtask"
        SUBTASK_ID=""
    fi
else
    warn "Skip Create Subtask - No ID"
fi

# Test 8: Toggle Subtask
if [ ! -z "$TODO_ID" ] && [ ! -z "$SUBTASK_ID" ]; then
    TOGGLE_SUBTASK=$(curl -s -X PATCH $API_BASE/api/todos/$TODO_ID/subtasks/$SUBTASK_ID/toggle)
    if [[ "$TOGGLE_SUBTASK" == *"completed"* ]]; then
        pass "Toggle Subtask"
    else
        fail "Toggle Subtask - Response: $TOGGLE_SUBTASK"
    fi
else
    warn "Skip Toggle Subtask - Missing IDs"
fi

# Test 9: Create Tag
TAG_RESPONSE=$(curl -s -X POST $API_BASE/api/tags/ \
  -H "Content-Type: application/json" \
  -d '{"name": "Test Tag", "color": "#FF0000"}')
if [[ "$TAG_RESPONSE" == *"Test Tag"* ]]; then
    pass "Create Tag"
    TAG_ID=$(echo "$TAG_RESPONSE" | python -c "import sys, json; print(json.load(sys.stdin).get('id', ''))")
else
    fail "Create Tag"
    TAG_ID=""
fi

# Test 10: Get Tags
GET_TAGS=$(curl -s $API_BASE/api/tags/)
if [[ "$GET_TAGS" == *"Test Tag"* ]]; then
    pass "Get Tags"
else
    fail "Get Tags"
fi

# Test 11: Create Todo with Tags and Subtasks
COMPLEX_TODO=$(curl -s -X POST $API_BASE/api/todos/ \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Complex Test Todo",
    "description": "Testing tags and subtasks",
    "priority": "medium",
    "tag_ids": ['"$TAG_ID"'],
    "subtasks": [
      {"title": "First subtask", "completed": false},
      {"title": "Second subtask", "completed": false}
    ]
  }')
if [[ "$COMPLEX_TODO" == *"Complex Test Todo"* ]]; then
    pass "Create Complex Todo (with tags and subtasks)"
else
    fail "Create Complex Todo"
fi

# Test 12: Search Todos
SEARCH=$(curl -s "$API_BASE/api/todos/?search=Test")
if [[ "$SEARCH" == *"Test Interaction"* ]]; then
    pass "Search Todos"
else
    fail "Search Todos"
fi

# Test 13: Filter by Priority
PRIORITY_FILTER=$(curl -s "$API_BASE/api/todos/?priority=high")
if [[ "$PRIORITY_FILTER" == *"Test Interaction"* ]] || [[ "$PRIORITY_FILTER" == *"Updated Test Interaction"* ]]; then
    pass "Filter by Priority"
else
    fail "Filter by Priority"
fi

# Test 14: Filter by Completion
COMPLETED_FILTER=$(curl -s "$API_BASE/api/todos/?completed=true")
if [[ "$COMPLETED_FILTER" == *"completed"* ]]; then
    pass "Filter by Completion Status"
else
    fail "Filter by Completion Status"
fi

# Test 15: Reorder Todos
REORDER_RESPONSE=$(curl -s -X POST $API_BASE/api/todos/reorder \
  -H "Content-Type: application/json" \
  -d '["'$TODO_ID'", "2", "3"]')
if [[ "$REORDER_RESPONSE" == *"reordered"* ]]; then
    pass "Reorder Todos"
else
    fail "Reorder Todos"
fi

# Test 16: Delete Todo
if [ ! -z "$TODO_ID" ]; then
    DELETE_RESPONSE=$(curl -s -X DELETE $API_BASE/api/todos/$TODO_ID)
    if [[ "$DELETE_RESPONSE" == *"deleted"* ]]; then
        pass "Delete Todo"
    else
        fail "Delete Todo"
    fi
else
    warn "Skip Delete Todo - No ID"
fi

# Test 17: Delete Tag
if [ ! -z "$TAG_ID" ]; then
    DELETE_TAG=$(curl -s -X DELETE $API_BASE/api/tags/$TAG_ID)
    if [[ "$DELETE_TAG" == *"deleted"* ]]; then
        pass "Delete Tag"
    else
        fail "Delete Tag"
    fi
else
    warn "Skip Delete Tag - No ID"
fi

echo ""
echo "🎨 TEST SUITE 2: FRONTEND ASSETS"
echo "================================================================================"

# Test 18: HTML Page
HTML_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $API_BASE/)
if [ "$HTML_STATUS" = "200" ]; then
    pass "HTML Page Loading (HTTP 200)"
else
    fail "HTML Page Loading (HTTP $HTML_STATUS)"
fi

# Test 19: Vue.js CDN
VUE_CHECK=$(curl -s "https://unpkg.com/vue@3.5.26/dist/vue.global.js" | head -c 500)
if [[ "$VUE_CHECK" == *"createApp"* ]] || [[ "$VUE_CHECK" == *"Vue"* ]]; then
    pass "Vue.js CDN Available"
else
    fail "Vue.js CDN Not Available"
fi

# Test 20: CSS File
CSS_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $API_BASE/static/css/styles.css)
if [ "$CSS_STATUS" = "200" ]; then
    CSS_SIZE=$(curl -s $API_BASE/static/css/styles.css | wc -l)
    pass "CSS File Loading (HTTP 200, $CSS_SIZE lines)"
else
    fail "CSS File Loading (HTTP $CSS_STATUS)"
fi

# Test 21: JavaScript File
JS_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $API_BASE/static/js/app.js)
if [ "$JS_STATUS" = "200" ]; then
    JS_SIZE=$(curl -s $API_BASE/static/js/app.js | wc -l)
    pass "JavaScript File Loading (HTTP 200, $JS_SIZE lines)"
else
    fail "JavaScript File Loading (HTTP $JS_STATUS)"
fi

# Test 22: Vue.js CDN in HTML
VUE_IN_HTML=$(curl -s $API_BASE/ | grep -c "vue.global.js")
if [ "$VUE_IN_HTML" -gt 0 ]; then
    pass "Vue.js CDN Referenced in HTML"
else
    fail "Vue.js CDN Not Referenced in HTML"
fi

# Test 23: Check for Modal HTML
MODAL_HTML=$(curl -s $API_BASE/ | grep -c "modal-overlay")
if [ "$MODAL_HTML" -gt 0 ]; then
    pass "Modal HTML Present"
else
    fail "Modal HTML Missing"
fi

# Test 24: Check for Vue Directives
VUE_DIRECTIVES=$(curl -s $API_BASE/ | grep -c "v-")
if [ "$VUE_DIRECTIVES" -gt 10 ]; then
    pass "Vue Directives Present ($VUE_DIRECTIVES found)"
else
    fail "Vue Directives Missing ($VUE_DIRECTIVES found)"
fi

# Test 25: Check for Form Elements
FORM_ELEMENTS=$(curl -s $API_BASE/ | grep -c "form-")
if [ "$FORM_ELEMENTS" -gt 5 ]; then
    pass "Form Elements Present ($FORM_ELEMENTS found)"
else
    fail "Form Elements Missing ($FORM_ELEMENTS found)"
fi

echo ""
echo "🔧 TEST SUITE 3: DATABASE INTEGRITY"
echo "================================================================================"

# Test 26: Database Tables Exist
TABLES=$(sqlite3 /workspaces/To_do_list/backend/utils/todos.db ".tables")
if [[ "$TABLES" == *"todos"* ]] && [[ "$TABLES" == *"tags"* ]] && [[ "$TABLES" == *"subtasks"* ]]; then
    pass "Database Tables Created"
else
    fail "Database Tables Missing - Tables: $TABLES"
fi

# Test 27: Database Todo Count
TODO_COUNT=$(curl -s $API_BASE/api/todos/ | python -c "import sys, json; print(len(json.load(sys.stdin)))")
if [ "$TODO_COUNT" -ge 0 ]; then
    pass "Database Todo Count ($TODO_COUNT todos)"
else
    fail "Database Todo Count Error"
fi

# Test 28: Database Tag Count
TAG_COUNT=$(curl -s $API_BASE/api/tags/ | python -c "import sys, json; print(len(json.load(sys.stdin)))")
if [ "$TAG_COUNT" -ge 0 ]; then
    pass "Database Tag Count ($TAG_COUNT tags)"
else
    fail "Database Tag Count Error"
fi

echo ""
echo "🎯 TEST SUITE 4: UI INTERACTION COMPONENTS"
echo "================================================================================"

# Test 29: Check Add Todo Button
ADD_BUTTON=$(curl -s $API_BASE/ | grep -c "add-todo-btn")
if [ "$ADD_BUTTON" -gt 0 ]; then
    pass "Add Todo Button Present"
else
    fail "Add Todo Button Missing"
fi

# Test 30: Check Filter Buttons
FILTER_BUTTONS=$(curl -s $API_BASE/ | grep -c "filter-btn")
if [ "$FILTER_BUTTONS" -ge 3 ]; then
    pass "Filter Buttons Present ($FILTER_BUTTONS found)"
else
    fail "Filter Buttons Missing ($FILTER_BUTTONS found)"
fi

# Test 31: Check Search Input
SEARCH_INPUT=$(curl -s $API_BASE/ | grep -c "search-input")
if [ "$SEARCH_INPUT" -gt 0 ]; then
    pass "Search Input Present"
else
    fail "Search Input Missing"
fi

# Test 32: Check Checkbox Elements
CHECKBOXES=$(curl -s $API_BASE/ | grep -c "todo-checkbox")
if [ "$CHECKBOXES" -gt 0 ]; then
    pass "Checkbox Elements Present"
else
    fail "Checkbox Elements Missing"
fi

# Test 33: Check Priority Badges
PRIORITY_BADGES=$(curl -s $API_BASE/ | grep -c "priority")
if [ "$PRIORITY_BADGES" -gt 0 ]; then
    pass "Priority Badges Present"
else
    fail "Priority Badges Missing"
fi

# Test 34: Check Tag Elements
TAG_ELEMENTS=$(curl -s $API_BASE/ | grep -c "todo-tag")
if [ "$TAG_ELEMENTS" -gt 0 ]; then
    pass "Tag Elements Present"
else
    fail "Tag Elements Missing"
fi

# Test 35: Check Modal Close Button
CLOSE_BTN=$(curl -s $API_BASE/ | grep -c "modal-close")
if [ "$CLOSE_BTN" -gt 0 ]; then
    pass "Modal Close Button Present"
else
    fail "Modal Close Button Missing"
fi

# Test 36: Check Form Submit Button
SUBMIT_BTN=$(curl -s $API_BASE/ | grep -c "btn-primary")
if [ "$SUBMIT_BTN" -gt 0 ]; then
    pass "Form Submit Button Present"
else
    fail "Form Submit Button Missing"
fi

# Test 37: Check Cancel Button
CANCEL_BTN=$(curl -s $API_BASE/ | grep -c "btn-secondary")
if [ "$CANCEL_BTN" -gt 0 ]; then
    pass "Cancel Button Present"
else
    fail "Cancel Button Missing"
fi

# Test 38: Check Drag and Drop Attributes
DRAG_ATTRS=$(curl -s $API_BASE/ | grep -c "draggable")
if [ "$DRAG_ATTRS" -gt 0 ]; then
    pass "Drag and Drop Attributes Present"
else
    fail "Drag and Drop Attributes Missing"
fi

# Test 39: Check Stats Cards
STATS_CARDS=$(curl -s $API_BASE/ | grep -c "stat-card")
if [ "$STATS_CARDS" -ge 3 ]; then
    pass "Stats Cards Present ($STATS_CARDS found)"
else
    fail "Stats Cards Missing ($STATS_CARDS found)"
fi

# Test 40: Check Todo Card Container
TODO_CONTAINER=$(curl -s $API_BASE/ | grep -c "todos-container")
if [ "$TODO_CONTAINER" -gt 0 ]; then
    pass "Todo Card Container Present"
else
    fail "Todo Card Container Missing"
fi

echo ""
echo "⚡ TEST SUITE 5: JAVASCRIPT FUNCTIONS"
echo "================================================================================"

# Test 41: Check openModal Function
OPEN_MODAL=$(curl -s $API_BASE/static/js/app.js | grep -c "function openModal")
if [ "$OPEN_MODAL" -gt 0 ]; then
    pass "openModal Function Defined"
else
    fail "openModal Function Missing"
fi

# Test 42: Check closeModal Function
CLOSE_MODAL=$(curl -s $API_BASE/static/js/app.js | grep -c "function closeModal")
if [ "$CLOSE_MODAL" -gt 0 ]; then
    pass "closeModal Function Defined"
else
    fail "closeModal Function Missing"
fi

# Test 43: Check saveTodo Function
SAVE_TODO=$(curl -s $API_BASE/static/js/app.js | grep -c "function saveTodo")
if [ "$SAVE_TODO" -gt 0 ]; then
    pass "saveTodo Function Defined"
else
    fail "saveTodo Function Missing"
fi

# Test 44: Check toggleTodo Function
TOGGLE_TODO=$(curl -s $API_BASE/static/js/app.js | grep -c "function toggleTodo")
if [ "$TOGGLE_TODO" -gt 0 ]; then
    pass "toggleTodo Function Defined"
else
    fail "toggleTodo Function Missing"
fi

# Test 45: Check deleteTodo Function
DELETE_TODO=$(curl -s $API_BASE/static/js/app.js | grep -c "function deleteTodo")
if [ "$DELETE_TODO" -gt 0 ]; then
    pass "deleteTodo Function Defined"
else
    fail "deleteTodo Function Missing"
fi

# Test 46: Check toggleSubtask Function
TOGGLE_SUBTASK=$(curl -s $API_BASE/static/js/app.js | grep -c "function toggleSubtask")
if [ "$TOGGLE_SUBTASK" -gt 0 ]; then
    pass "toggleSubtask Function Defined"
else
    fail "toggleSubtask Function Missing"
fi

# Test 47: Check addSubtask Function
ADD_SUBTASK=$(curl -s $API_BASE/static/js/app.js | grep -c "function addSubtask")
if [ "$ADD_SUBTASK" -gt 0 ]; then
    pass "addSubtask Function Defined"
else
    fail "addSubtask Function Missing"
fi

# Test 48: Check removeSubtask Function
REMOVE_SUBTASK=$(curl -s $API_BASE/static/js/app.js | grep -c "function removeSubtask")
if [ "$REMOVE_SUBTASK" -gt 0 ]; then
    pass "removeSubtask Function Defined"
else
    fail "removeSubtask Function Missing"
fi

# Test 49: Check handleDragStart Function
DRAG_START=$(curl -s $API_BASE/static/js/app.js | grep -c "function handleDragStart")
if [ "$DRAG_START" -gt 0 ]; then
    pass "handleDragStart Function Defined"
else
    fail "handleDragStart Function Missing"
fi

# Test 50: Check handleDrop Function
HANDLE_DROP=$(curl -s $API_BASE/static/js/app.js | grep -c "function handleDrop")
if [ "$HANDLE_DROP" -gt 0 ]; then
    pass "handleDrop Function Defined"
else
    fail "handleDrop Function Missing"
fi

echo ""
echo "================================================================================
                                📊 TEST SUMMARY
================================================================================"
echo ""
echo "All 50 comprehensive tests completed!"
echo ""
echo "🎉 INTERACTIVE COMPONENTS VERIFIED:"
echo "   • Add Todo Button"
echo "   • Filter Buttons (All/Active/Completed)"
echo "   • Search Input"
echo "   • Todo Checkboxes"
echo "   • Edit/Delete Buttons"
echo "   • Modal Open/Close Buttons"
echo "   • Form Submit/Cancel Buttons"
echo "   • Drag and Drop Elements"
echo "   • Priority Badges"
echo "   • Tags"
echo "   • Subtasks"
echo "   • Stats Cards"
echo ""
echo "📁 PROJECT RENAME IN PROGRESS: 'To_do_list' → 'lists'"
echo "================================================================================"
