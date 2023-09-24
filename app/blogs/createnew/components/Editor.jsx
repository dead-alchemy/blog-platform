"use client";

import "@mdxeditor/editor/style.css";
import { MDXEditor, MDXEditorMethods } from "@mdxeditor/editor";
import { headingsPlugin } from "@mdxeditor/editor/plugins/headings";
import { listsPlugin } from "@mdxeditor/editor/plugins/lists";
import { quotePlugin } from "@mdxeditor/editor/plugins/quote";
import { thematicBreakPlugin } from "@mdxeditor/editor/plugins/thematic-break";

import { UndoRedo } from "@mdxeditor/editor/plugins/toolbar/components/UndoRedo";
import { BoldItalicUnderlineToggles } from "@mdxeditor/editor/plugins/toolbar/components/BoldItalicUnderlineToggles";
import { toolbarPlugin } from "@mdxeditor/editor/plugins/toolbar";

const Editor = ({ editorRef, markdown }) => {
	return (
		<MDXEditor
			ref={editorRef}
			markdown={markdown}
			plugins={[
				headingsPlugin(),
				listsPlugin(),
				quotePlugin(),
				thematicBreakPlugin(),
				toolbarPlugin({
					toolbarContents: () => (
						<>
							<UndoRedo />
							<BoldItalicUnderlineToggles />
						</>
					),
				}),
			]}
		/>
	);
};

export default Editor;
