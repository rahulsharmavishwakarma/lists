# User Guide

Welcome to the Notion-Style Todo List! This guide will help you get the most out of the application.

## Table of Contents

- [Getting Started](#getting-started)
- [Creating Tasks](#creating-tasks)
- [Managing Tasks](#managing-tasks)
- [Organizing with Tags](#organizing-with-tags)
- [Using Subtasks](#using-subtasks)
- [Filtering and Searching](#filtering-and-searching)
- [Priority Management](#priority-management)
- [Due Dates](#due-dates)
- [Statistics](#statistics)
- [Tips and Tricks](#tips-and-tricks)
- [Keyboard Shortcuts](#keyboard-shortcuts)

---

## Getting Started

### First Steps

1. **Open the application**
   - Navigate to `http://localhost:8000` (development)
   - Or your production URL

2. **Create your first task**
   - Click the "Add a new task" button
   - Enter a task title
   - Click "Save Task"

3. **Explore the interface**
   - Try marking tasks as complete
   - Add tags and subtasks
   - Use filters and search

---

## Creating Tasks

### Basic Task Creation

1. Click the **"Add a new task"** button at the top
2. Enter a **title** (required)
3. Optionally add:
   - Description
   - Priority level
   - Due date
   - Tags
   - Subtasks
4. Click **"Save Task"**

### Task Fields Explained

| Field | Description | Required |
|--------|-------------|-----------|
| **Title** | Short task name | Yes |
| **Description** | Detailed explanation | No |
| **Priority** | Importance level (Low/Medium/High) | No (default: Medium) |
| **Due Date** | When the task should be completed | No |
| **Tags** | Color-coded labels for organization | No |
| **Subtasks** | Smaller tasks to break down work | No |

### Creating a Complete Task Example

```
Title: "Complete project documentation"
Description: "Write comprehensive documentation including API docs, user guide, and architecture overview"
Priority: High
Due Date: 2026-01-15
Tags: Work, Documentation
Subtasks: 
  - Write API reference
  - Create user guide
  - Document architecture
```

---

## Managing Tasks

### Marking Tasks Complete

**Method 1: Quick Toggle**
- Click the checkbox next to any task
- The task will be visually marked as complete (strikethrough text)

**Method 2: Using Edit**
- Click the "Edit" button
- Check the "Completed" checkbox
- Click "Save Task"

### Editing Tasks

1. Click the **"✏️ Edit"** button on a task
2. Modify any fields you want
3. Click **"Save Task"**

**Tip:** Changes are saved immediately. No need to close the modal.

### Deleting Tasks

1. Click the **"🗑️ Delete"** button on a task
2. Confirm the deletion
3. The task and all its subtasks will be removed

**Warning:** Deletion is permanent. There's no undo (yet).

### Reordering Tasks

**Drag and Drop:**
1. Click and hold on a task card
2. Drag it to the desired position
3. Release the mouse button

The new order is automatically saved.

---

## Organizing with Tags

### Creating Tags

1. Click **"+ Add tag"** in the sidebar
2. Enter a tag name
3. Choose a color
4. Click **"Create Tag"**

**Example Tags:**
- Work (Blue)
- Personal (Green)
- Urgent (Red)
- Ideas (Yellow)

### Assigning Tags to Tasks

1. When creating or editing a task
2. Click on the tags you want to assign
3. Selected tags will be highlighted
4. Save the task

### Filtering by Tags

1. Click on any tag in the sidebar
2. Only tasks with that tag will be shown
3. Click the tag again or "All" to clear filter

**Note:** You can filter by multiple tags (future feature).

### Deleting Tags

1. Hover over the tag in the sidebar
2. Click the delete icon (future feature)
3. Tag will be removed from all tasks

---

## Using Subtasks

### Adding Subtasks

**When Creating a Task:**
1. In the "Subtasks" section, click **"+ Add subtask"**
2. Enter the subtask title
3. Click the button again to add more subtasks
4. Save the task

**When Editing a Task:**
1. Click "Edit" on the task
2. Scroll to "Subtasks" section
3. Add or modify subtasks
4. Save the task

### Managing Subtasks

**Toggle Subtask Completion:**
- Click the checkbox next to each subtask
- Subtasks can be completed independently of the parent task

**Progress Tracking:**
- Each task shows subtask progress: "2/5 subtasks"
- Visual progress bar (future feature)

**Deleting Subtasks:**
1. Click "Edit" on the parent task
2. Click the **"×"** button next to the subtask
3. Save the task

### Subtask Best Practices

✅ **Do:**
- Break down large tasks into smaller subtasks
- Make subtasks actionable and specific
- Use subtasks for step-by-step processes

❌ **Don't:**
- Create too many subtasks (keep it under 10)
- Make subtasks too vague
- Forget to update parent task when subtasks change

---

## Filtering and Searching

### Status Filters

Located at the top of the page:

- **All**: Shows all tasks (default)
- **Active**: Shows incomplete tasks only
- **Completed**: Shows completed tasks only

### Priority Filters

Located in the sidebar:

- **All**: Show all priorities
- **🔴 High**: Show high-priority tasks
- **🟡 Medium**: Show medium-priority tasks
- **🟢 Low**: Show low-priority tasks

### Search

Located at the top right:

1. Type in the search box
2. Results update as you type
3. Searches in:
   - Task titles
   - Task descriptions

**Search Tips:**
- Use specific keywords for better results
- Search is case-insensitive
- Clear search by clicking the X (future feature)

### Combining Filters

You can combine multiple filters:

**Example:**
- Filter by "Active" status
- Filter by "High" priority
- Filter by "Work" tag
- Search for "documentation"

Result: Only shows active, high-priority, work-tagged tasks with "documentation" in the title or description.

---

## Priority Management

### Understanding Priorities

| Priority | Color | Use Case |
|----------|--------|-----------|
| **🔴 High** | Red | Urgent tasks, deadlines today |
| **🟡 Medium** | Yellow | Regular tasks, normal importance |
| **🟢 Low** | Green | Optional tasks, nice to have |

### Setting Priority

**When Creating:**
- Select priority from dropdown
- Default is "Medium"

**When Editing:**
- Change priority in edit modal
- Priority color updates immediately

### Visual Indicators

- Priority is shown as a colored badge on each task
- Helps quickly identify urgent tasks
- Can be used for sorting/filtering

### Best Practices

✅ **Do:**
- Use high priority sparingly (for truly urgent tasks)
- Review priorities daily
- Re-prioritize as situations change

❌ **Don't:**
- Make everything high priority (defeats the purpose)
- Ignore priority when planning
- Set and forget (priorities change)

---

## Due Dates

### Setting Due Dates

1. When creating or editing a task
2. Click on the due date field
3. Select date and time
4. Save the task

### Due Date Display

- Due dates appear as a calendar icon with date
- Example: 📅 Jan 15, 2026
- Example with time: 📅 Jan 15, 2026 2:00 PM

### Overdue Tasks

- Tasks past their due date are highlighted in red
- Only applies to incomplete tasks
- Helps identify late tasks

### Managing Due Dates

**Best Practices:**
- Set realistic due dates
- Review due dates regularly
- Update dates when priorities change
- Use for tasks with actual deadlines, not everything

---

## Statistics

### Stats Bar

Located below the add button:

```
┌─────────┬─────────┬──────────┐
│  Total  │ Active  │Completed │
│   12    │   8     │    4     │
└─────────┴─────────┴──────────┘
```

### What Each Stat Means

- **Total**: All tasks in the system
- **Active**: Incomplete tasks
- **Completed**: Finished tasks

### Stats Update

- Statistics update automatically
- Changes reflect immediately after task modifications
- No refresh needed

---

## Tips and Tricks

### Productivity Tips

1. **Plan Your Day**
   - Start with a quick review
   - Focus on high-priority tasks
   - Aim to complete 3-5 important tasks

2. **Use Subtasks Effectively**
   - Break down complex tasks
   - Celebrate small wins (completing subtasks)
   - Stay motivated with progress

3. **Review Regularly**
   - Daily: Review and update priorities
   - Weekly: Review completed tasks, archive
   - Monthly: Organize tags, cleanup

4. **Use Tags Smartly**
   - Create meaningful tags (not too many)
   - Use tags for context (Work, Home, Projects)
   - Color-code for quick recognition

### Organization Tips

1. **Keep Titles Short**
   - Clear and concise
   - Use description for details
   - Example: "Email John" instead of "Send email to John about the meeting on Tuesday regarding the project"

2. **Use Descriptions**
   - Add context and details
   - Include relevant information
   - Example: links, requirements, notes

3. **Prioritize Honestly**
   - Not everything is urgent
   - Be realistic about importance
   - Change priorities when needed

### Workflow Tips

**GTD (Getting Things Done) Style:**
1. Capture everything as tasks
2. Organize with tags
3. Review and prioritize
4. Do the work

**Pomodoro Style:**
1. Pick a task
2. Work for 25 minutes
3. Take a 5-minute break
4. Repeat 4 times, then longer break

---

## Keyboard Shortcuts

(Planned for future updates)

Currently, keyboard shortcuts are not implemented. Planned shortcuts:

| Shortcut | Action |
|----------|--------|
| `N` | Create new task |
| `S` | Focus search |
| `A` | Show all tasks |
| `C` | Show completed only |
| `E` | Toggle edit mode |
| `Space` | Toggle task completion |
| `Esc` | Close modal |

---

## Troubleshooting

### Common Issues

**Task not saving:**
- Check that title is filled in
- Try refreshing the page
- Check browser console for errors

**Search not working:**
- Clear search box and try again
- Refresh the page
- Check that task exists

**Drag and drop not working:**
- Use a modern browser (Chrome, Firefox, Safari)
- Update your browser
- Try clicking instead of dragging

**Tasks disappeared:**
- Check your filters (might be filtering them out)
- Clear all filters
- Check if tags are selected

---

## Browser Compatibility

### Supported Browsers

- ✅ Chrome 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+

### Mobile Support

- ✅ Responsive design works on all devices
- ✅ Touch-friendly interface
- ✅ Optimized for mobile screens

### Recommended Settings

- Enable JavaScript (required)
- Enable cookies (for session management)
- Allow popups for this site

---

## Data Privacy

### Your Data

- Tasks are stored in a database (SQLite or PostgreSQL)
- No data is sent to third-party servers
- No tracking or analytics

### Export/Import

(Planned feature)
- Export tasks to JSON/CSV
- Import tasks from backup
- Sync across devices

---

## Getting Help

### Questions?

- Check this user guide
- Read the [API Documentation](API.md)
- Review [Architecture Docs](ARCHITECTURE.md)
- Open an issue on GitHub

### Feature Requests?

We'd love to hear from you! Please:
1. Check if the feature exists
2. Open an issue with your suggestion
3. Describe the use case and benefits

### Bugs Found?

Please report bugs with:
1. Steps to reproduce
2. Expected vs actual behavior
3. Browser and version
4. Screenshots (if applicable)

---

## Advanced Usage

### Power User Tips

1. **Bulk Operations** (planned)
   - Select multiple tasks
   - Bulk delete/archive
   - Bulk tag assignment

2. **Custom Views** (planned)
   - Save filter combinations
   - Create dashboard views
   - Quick access to common views

3. **Keyboard Navigation** (planned)
   - Arrow keys to navigate
   - Enter to open edit
   - Space to toggle

---

## FAQ

**Q: Can I use this offline?**  
A: Currently, no. Offline support is planned for a future update.

**Q: Is my data private?**  
A: Yes, if you're self-hosting. Your data stays on your server.

**Q: Can I share my tasks?**  
A: Not yet, but collaboration features are planned.

**Q: What happens if I delete a task?**  
A: The task and all subtasks are permanently deleted.

**Q: Can I undo deletions?**  
A: Not currently. This feature is on our roadmap.

**Q: How many tasks can I create?**  
A: There's no limit, but performance may decrease with thousands of tasks.

**Q: Can I import tasks from other apps?**  
A: Not directly, but you can use the API to import data.

---

## Updates

Stay informed about new features and improvements by:
- Checking the GitHub repository
- Reading the changelog
- Following project announcements

---

**Happy task management! 🎉**

If you find this guide helpful, please star the repository on GitHub!
