# TASK: Update README.md with Comprehensive Documentation

**Status**: READY
**Priority**: P1
**Estimated Duration**: 15 minutes

## Context

### Current State

- README.md: 4 lines, default LazyVim template text
- Location: `/Users/fanlz/.config/nvim/README.md`
- No project-specific information

### Target State

- Comprehensive README reflecting actual configuration
- Include: features, setup, plugins, keybindings, requirements
- Use CLAUDE.md content as reference (already contains detailed info)

### Documentation to Reference

```yaml
docs:
  - file: CLAUDE.md (lines 185-370)
    focus: Project structure, plugins, keybindings, setup instructions
  - file: lua/config/lazy.lua
    focus: Plugin management architecture
  - file: .env
    focus: Required environment variables (DO NOT expose actual keys)
```

### Patterns

```yaml
patterns:
  - Convention: Use emoji for section headers (💤 LazyVim style)
  - Format: Markdown with code blocks for examples
  - Structure: Features → Setup → Usage → Development
  - Reference: Keep links to official LazyVim docs
```

### Gotchas

```yaml
gotchas:
  - issue: ".env contains sensitive API keys"
    fix: "Document WHICH keys needed, NOT actual values"

  - issue: "README should be concise, not duplicate CLAUDE.md"
    fix: "Focus on getting started, not implementation details"
```

## Tasks

### TASK 1: Replace README.md with project overview

**File**: `README.md`

**Operation**: REPLACE entire content with:
- Project title and description
- Key features list (16 plugins)
- Technology stack
- Badge/status section (optional)

**Validation**:
```bash
# Check file exists and has content
test -f README.md && wc -l README.md | grep -E "^[3-9][0-9]|^[1-9][0-9]{2,}"
```

**Content Requirements**:
- Emoji header: 💤 title
- Subtitle: LazyVim-based configuration
- Feature highlights: AI integration, 16+ plugins, Emacs-style keybindings
- Tech stack: Neovim, LazyVim, lazy.nvim, Lua

**IF_FAIL**:
- Check file permissions: `ls -la README.md`
- Verify write access to directory

**ROLLBACK**:
```bash
git checkout HEAD -- README.md
```

---

### TASK 2: Add prerequisites and setup section

**File**: `README.md`

**Operation**: APPEND installation requirements and setup steps

**Validation**:
```bash
grep -q "Prerequisites" README.md && grep -q "Installation" README.md
```

**Content Requirements**:
- Prerequisites:
  - Neovim >= 0.9.0
  - Git
  - A Nerd Font (terminal font)
  - `clipboard-provider` command (for clipboard sync)

- Setup steps:
  1. Clone/symlink to ~/.config/nvim
  2. Install plugins: Launch nvim, wait for lazy.nvim
  3. Configure .env file (list required vars without values)
  4. Optional: Setup .mcp.json for MCP servers

**IF_FAIL**:
- Check section ordering: Prerequisites should come before Installation
- Verify markdown formatting

**ROLLBACK**: Use git to restore previous version

---

### TASK 3: Add plugins overview section

**File**: `README.md`

**Operation**: APPEND categorized plugin list

**Validation**:
```bash
grep -q "## Plugins" README.md && grep -c "claude-code-server" README.md | grep "1"
```

**Content Requirements**:

Group plugins by category:
- **AI Integration**: ClaudeCode.nvim
- **File Management**: nvim-tree
- **Search & Navigation**: telescope, dropbar, outline
- **Code Completion**: blink
- **UI Enhancement**: gruvbox, bufferline, colorful-menu, snacks
- **Development Tools**: rest.nvim (kulala), openapi, markdown-preview
- **Utilities**: translator, fortune, tmux integration

Format: Brief description for each plugin (1 line max)

**IF_FAIL**:
- Count plugins: Should match 16 files in lua/plugins/
- Verify no duplicate entries

**ROLLBACK**: Remove "## Plugins" section and everything after it

---

### TASK 4: Add key bindings reference section

**File**: `README.md`

**Operation**: APPEND essential keybindings documentation

**Validation**:
```bash
grep -q "Key Bindings" README.md && grep -q "<leader>ab" README.md
```

**Content Requirements**:

Include ONLY most important bindings:

1. **Insert Mode Emacs Bindings**:
   - `<C-b>/<C-f>`: Move left/right
   - `<C-a>`: Move to line start
   - `<C-s>`: Save file

2. **Claude Code**:
   - `<leader>ab`: Add buffer to context
   - `<leader>aw`: Send selection/add from tree
   - `<leader>aj/ak`: Accept/reject diff

3. **REST Client**:
   - `<leader>Rs`: Send HTTP request
   - `<leader>Rt`: Toggle headers/body

Note: Link to lua/config/keymaps.lua for full list

**IF_FAIL**:
- Check key format: Should use backticks for keys
- Verify leader key mentioned

**ROLLBACK**: Remove "## Key Bindings" section

---

### TASK 5: Add development and configuration section

**File**: `README.md`

**Operation**: APPEND development commands and config notes

**Validation**:
```bash
grep -q "Development" README.md && grep -q "stylua" README.md
```

**Content Requirements**:

1. **Format Code**:
   ```bash
   stylua .
   ```

2. **Manage Plugins**:
   ```vim
   :Lazy sync
   :Lazy update
   ```

3. **Configuration Files**:
   - Core config: `lua/config/`
   - Plugin configs: `lua/plugins/`
   - Environment: `.env`
   - Style: `stylua.toml`

4. **Adding Plugins**: 3-step process
   - Create file in lua/plugins/
   - Return lazy.nvim spec
   - Restart Neovim

**IF_FAIL**:
- Verify code blocks have language tags (bash, vim, lua)
- Check that paths are relative to repo root

**ROLLBACK**: Remove "## Development" section

---

### TASK 6: Add footer with references

**File**: `README.md`

**Operation**: APPEND links and credits

**Validation**:
```bash
grep -q "LazyVim" README.md && grep -q "lazyvim.github.io" README.md
```

**Content Requirements**:
- Link to LazyVim documentation
- Link to lazy.nvim
- License reference (MIT from LICENSE file)
- Optional: Link to CLAUDE.md for AI assistant guidance

**IF_FAIL**:
- Check all URLs are valid
- Verify markdown link syntax

**ROLLBACK**: Remove footer section

---

### TASK 7: Final validation and formatting

**File**: `README.md`

**Operation**: VALIDATE complete README structure

**Validation**:
```bash
# Check all major sections exist
for section in "Prerequisites" "Installation" "Plugins" "Key Bindings" "Development"; do
  grep -q "$section" README.md || echo "Missing: $section"
done

# Check line count (should be substantial)
lines=$(wc -l < README.md)
[ "$lines" -gt 80 ] || echo "README too short: $lines lines"

# Check no sensitive data leaked
! grep -E "sk-|AIza|ghp_|hf_" README.md || echo "SECURITY: API keys detected!"
```

**Operation Details**:
- Run validation checks above
- Check markdown formatting (headers, lists, code blocks)
- Verify no .env secrets included
- Ensure consistent emoji usage
- Validate all section links work

**IF_FAIL**:
- If missing sections: Review tasks 1-6
- If API keys found: Remove and document key names only
- If formatting issues: Run through markdown linter

**ROLLBACK**:
```bash
git checkout HEAD -- README.md
```

---

## Success Criteria

- [ ] README.md > 80 lines
- [ ] All 6 main sections present
- [ ] No API keys or secrets included
- [ ] Markdown formatted correctly
- [ ] Links to LazyVim docs present
- [ ] Plugin list matches actual plugins (16)
- [ ] Key bindings documented
- [ ] Setup instructions clear

## Risk Assessment

**Low Risk**:
- Documentation-only change
- No code modification
- Easy rollback with git

**Potential Issues**:
- Accidentally including sensitive .env data → Mitigated by validation step
- README becoming too verbose → Keep concise, reference CLAUDE.md for details

## Performance Impact

None. Documentation only.

## Security Considerations

**CRITICAL**: Do NOT include actual API keys from .env file
- Document variable NAMES only
- Example format: `OPENAI_API_KEY=your_key_here`
- Validation step checks for key patterns

## Dependencies

- CLAUDE.md (reference for content)
- .env (reference for required variables - DO NOT copy values)
- lua/plugins/*.lua (count and list plugins)

## Rollback Strategy

Simple git restore:
```bash
git checkout HEAD -- README.md
# or
git restore README.md
```

## Estimated Time per Task

1. Project overview: 2 min
2. Prerequisites/Setup: 3 min
3. Plugins list: 3 min
4. Key bindings: 2 min
5. Development section: 3 min
6. Footer: 1 min
7. Validation: 1 min

**Total**: ~15 minutes

## Notes

- Use CLAUDE.md (lines 185-370) as primary reference
- Keep README concise and user-focused
- Detailed implementation info stays in CLAUDE.md
- This is for end users, not AI assistants
