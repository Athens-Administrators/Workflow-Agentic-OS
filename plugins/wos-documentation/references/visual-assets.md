# Workflow OS Visual Assets

Use this standard whenever a documentation request includes or may need screenshots, extracted video frames, diagrams, or visual callouts.

## Visual Intake Question

Before drafting or refreshing, decide whether visuals are needed. Ask only when the source or topic suggests visuals would improve the article, or when the user mentions screenshots, diagrams, videos, screen recordings, meetings, timestamps, UI steps, error dialogs, portals, settings pages, or screen-shared content.

Ask:

"Does this article need screenshots, diagrams, or visual callouts?"

If yes or implied, identify the visual source type:

- User-attached image.
- Local screenshot or image file.
- Browser or app screen that Codex can access in the current session.
- Local video file.
- Remote video URL.
- Meeting or recording timestamp.
- Existing Confluence, OneNote, PDF, Word, or slide asset.
- Diagram that should be generated from the documented process.

## Visual Asset Register

When visuals are needed, create a compact visual asset register before the full draft unless every required visual is already available and obvious.

Use this shape:

```md
## Visual Assets

- Type: screenshot | extracted frame | diagram | existing image
  Description: <what the visual must show>
  Source: <file, URL, timestamp, page, or user attachment>
  Status: available | can capture | can extract | can generate | needs manual capture | missing
  Placement: <target section or step>
  Sensitivity: <redaction notes or none known>
```

Keep this register concise. Do not let the register make the article longer than needed.

## Capture And Extraction Rules

Use available visuals when the user provides image files or screenshots.

Use browser or app screenshot tools only when the relevant screen is accessible in the current session and capturing it does not expose unnecessary sensitive data.

For local video files or remote video URLs, use an optional video-frame helper only when one is installed and usable in the current environment. If a `watch` or `/watch` skill is available, load its instructions and use it for frame extraction. A compatible helper may use tools such as `yt-dlp`, `ffmpeg`, captions, transcript extraction, or a `/watch`-style skill to create timestamped frames and a transcript.

Do not make video-frame extraction a required dependency for WOS Documentation. If no helper is available, continue with a timestamped screenshot target list.

For meeting tools such as Fathom or Zoom, do not claim screenshots can be pulled unless the connector exposes recording assets or downloadable video. If only transcripts, summaries, or timestamps are available, create exact timestamp capture targets instead.

## Supported Visual Source Providers

Use provider-specific helpers when they are available:

- Fathom: use Fathom meeting tools for transcript, summary, and timestamped screenshot targets. Treat Fathom as timestamp-first unless it returns or the user provides a real video/playback URL that the `watch` skill can access.
- Zoom Clips Pull: when the user asks for screenshots or frames from a Zoom Clip, use `zoom_clips_prepare_visual_asset` if available. Use `download: false` first to detect media candidates, then `download: true` only when the user asked for local frame extraction or screenshot capture. Hand the returned local file path to the `watch` skill or `ffmpeg` frame extraction.
- Zoom recordings: use available Zoom recording tools for playback URLs, transcripts, and recording metadata. Download video only when a tool or user-provided link exposes a downloadable recording asset and the user requested visual extraction.

If a provider cannot produce video bytes, do not block the documentation workflow. Create timestamped screenshot targets and exact placeholders.

## Diagrams

Use diagrams when they make the article easier to follow, especially for:

- Troubleshooting decision trees.
- Escalation paths.
- System flows.
- Process handoffs.
- Approval or intake workflows.

Prefer Mermaid for editable diagrams unless the user asks for a rendered image.

Keep diagrams small enough to support the article. Do not replace required written steps with a diagram.

## Draft Placement

When a visual is available, include a short placeholder in the draft using the intended file name or attachment name:

```md
![Alt text describing the screenshot](attachment:example-screenshot.png)

Caption: <short caption that explains why this visual matters>
```

When a visual is missing, include an exact placeholder:

```md
[Screenshot needed: <exact screen, state, or field to capture>]
```

Each visual must have:

- Clear placement in the article.
- Alt text or a meaningful placeholder.
- A short caption when it helps the reader.
- Source or capture target.
- Sensitivity/redaction status.

## Screenshot Redaction

Before publishing, check screenshots and frames for sensitive information:

- Real names.
- Email addresses.
- Device names or asset tags.
- Ticket numbers.
- IP addresses.
- License counts.
- Tenant names or internal URLs.
- Secrets, tokens, keys, or credentials.

If redaction is needed and cannot be completed, keep the visual out of the publish-ready version and leave a precise placeholder instead.

## Publish Preflight

Before publishing or updating Confluence, confirm:

- Required visuals are available, generated, extracted, or intentionally left as placeholders.
- Missing visuals have exact placeholders.
- Screenshots and frames have been reviewed for sensitive content.
- Captions and alt text are present when images are included.
- Diagrams are readable and do not contradict the written procedure.

Do not block a useful text-only article just because screenshots are unavailable. Use placeholders or a visual asset register when screenshots will be added later.
