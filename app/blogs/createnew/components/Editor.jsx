"use client";

import "@mdxeditor/editor/style.css";
import { MDXEditor, MDXEditorMethods } from "@mdxeditor/editor";
import { headingsPlugin } from "@mdxeditor/editor/plugins/headings";
import { listsPlugin } from "@mdxeditor/editor/plugins/lists";
import { quotePlugin } from "@mdxeditor/editor/plugins/quote";
import { thematicBreakPlugin } from "@mdxeditor/editor/plugins/thematic-break";

import { UndoRedo } from "@mdxeditor/editor/plugins/toolbar/components/UndoRedo";
import { BoldItalicUnderlineToggles } from "@mdxeditor/editor/plugins/toolbar/components/BoldItalicUnderlineToggles";
import { CodeToggle } from "@mdxeditor/editor/plugins/toolbar/components/CodeToggle";
import { InsertCodeBlock } from "@mdxeditor/editor/plugins/toolbar/components/InsertCodeBlock";
import { BlockTypeSelect } from "@mdxeditor/editor/plugins/toolbar/components/BlockTypeSelect";
import { toolbarPlugin } from "@mdxeditor/editor/plugins/toolbar";
import "./editor.css";

const Editor = ({ editorRef, markdown, handleChange }) => {
	return (
		<MDXEditor
			ref={editorRef}
			className="editor"
			markdown={markdown}
			onChange={handleChange}
			plugins={[
				headingsPlugin(),
				listsPlugin(),
				quotePlugin(),
				thematicBreakPlugin(),
				toolbarPlugin({
					toolbarContents: () => (
						<>
							<UndoRedo />
							<BlockTypeSelect />
							<BoldItalicUnderlineToggles />
							<CodeToggle />
							<InsertCodeBlock />
						</>
					),
				}),
			]}
		/>
	);
};

export default Editor;
