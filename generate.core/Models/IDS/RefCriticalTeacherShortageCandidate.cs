﻿using System;
using System.Collections.Generic;

namespace generate.core.Models.IDS
{
    public partial class RefCriticalTeacherShortageCandidate
    {
        public RefCriticalTeacherShortageCandidate()
        {
            ProgramParticipationTeacherPrep = new HashSet<ProgramParticipationTeacherPrep>();
        }

        public int RefCriticalTeacherShortageCandidateId { get; set; }
        public string Description { get; set; }
        public string Code { get; set; }
        public string Definition { get; set; }
        public int? RefJurisdictionId { get; set; }
        public decimal? SortOrder { get; set; }

        public virtual ICollection<ProgramParticipationTeacherPrep> ProgramParticipationTeacherPrep { get; set; }
        public virtual Organization RefJurisdiction { get; set; }
    }
}